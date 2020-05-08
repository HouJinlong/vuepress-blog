---

title: js-Performance获取文件size

meta:

  - name: description

    content: js中使用Performance获取文件size

  - name: keywords

    content: js,Performance,文件size,图片size

date: 2020-04-29

update_date: 2020-04-30
 
tags: 

  - js

banner: https://cdn.jsdelivr.net/gh/HouJinlong/pic@master/2020-04-29/console.png
---

背景：今天 每周例行技术分享 的时候，有位同事说 `js 获取不到文件大小：浏览器默认不允许js 执行IO操作。` 举了个例子，比如想获取一个图片地址的文件大小，因为之前做过图片上传功能所以比较敏感，感觉应该是可以的，虽然他说网上找过很多资料但是都不行，但是这种东西 只有自己试试才安心嘛~~

## 失败方案 canvas.toBlob 

```js
function loadImg(url){
    return new Promise((res, rej) => {
        const img = new Image()
        img.crossOrigin = ''   // 防止img 画在canvas上时报跨域错误
        img.onload = function() {
            res(this)
        }
        img.onerror = function() {
            rej()
        }
        img.src = url
    })
}

async function getImgSize(url) {
    const urlArr = url.split('.')
    const mime = "image/" + urlArr[urlArr.length-1]
    const img = await loadImg(url)
    const {width,height} = img
    const canvas = document.createElement('canvas')
    const ctx = canvas.getContext('2d');
    canvas.width = width;
    canvas.height = height;
    ctx.drawImage(img,0,0,width,height)
    canvas.toBlob(
        blob => {
            console.log(url,blob,(blob.size / 1000)+'KB')
        },
        mime
    );
}

getImgSize('https://images.daojia.com/changsha/banner/pic/25675a8d10bfa08e9599d2deb9a44eae.jpeg')

```
看日志输出，emmmmm 有模有样

![canvas.toBlob](http://ww1.sinaimg.cn/large/006I5hBxly1geblivm55fj30ng028749.jpg)

但实际.... 与 本地 和 Network 差 十万八千里

![network](https://cdn.jsdelivr.net/gh/HouJinlong/pic@master/2020-04-29/network.png)

<YurImg src="http://ww1.sinaimg.cn/large/006I5hBxly1gebm35owwkj30bp0i33z5.jpg" alt="" />

> 我尝试了几个图片,每个图片都比之前要大，而且增大程度不一定,这块估计是canvas画了一遍的原因

仔细看看接口 [HTMLCanvasElement.toBlob() MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/HTMLCanvasElement/toBlob)发现了一个以前没注意的地方 `第三个参数用于针对image/jpeg格式的图片进行输出图片的质量设置。`

<YurImg src="https://cdn.jsdelivr.net/gh/HouJinlong/pic@master/2020-04-29/encoderOptions.png" alt="" /> 

## 失败方法 canvas.toDataURL  + dataURLtoBlob

这是个还未开始就被认定的方案~~~~~~

```js
function loadImg(url){
    return new Promise((res, rej) => {
        const img = new Image()
        img.crossOrigin = ''   // 防止img 画在canvas上时报跨域错误
        img.onload = function() {
            res(this)
        }
        img.onerror = function() {
            rej()
        }
        img.src = url
    })
}

async function getImgSize(url) {
    const urlArr = url.split('.')
    const mime = "image/" + urlArr[urlArr.length-1]
    const img = await loadImg(url)
    const {width,height} = img
    const canvas = document.createElement('canvas')
    const ctx = canvas.getContext('2d');
    canvas.width = width;
    canvas.height = height;
    ctx.drawImage(img,0,0,width,height);
    const blob =  dataURLtoBlob(canvas.toDataURL(mime));
    console.log(url,blob,(blob.size / 1000)+'KB')
}
function dataURLtoBlob(dataurl) {
    var arr = dataurl.split(',');
    var _arr = arr[1].substring(0,arr[1].length-2);
    var mime = arr[0].match(/:(.*?);/)[1],
        bstr =atob(_arr),
        n = bstr.length,
        u8arr = new Uint8Array(n);
    while (n--) {
        u8arr[n] = bstr.charCodeAt(n);
    }
    return new Blob([u8arr], {
        type: mime
    });
}

getImgSize('https://images.daojia.com/changsha/banner/pic/25675a8d10bfa08e9599d2deb9a44eae.jpeg')
```
![canvas.toDataURL](http://ww1.sinaimg.cn/large/006I5hBxly1gebl7ql5juj30nj02o749.jpg)

> 好嘛比 canvas.toBlob 小了 0.002kb 离成功近了一大步

## 成功方案 performance

![Network](https://cdn.jsdelivr.net/gh/HouJinlong/pic@master/2020-04-29/console.png)

难道真的没有办法了嘛？我盯着 浏览器Network 陷入沉思, 突然 Network 资源加载 的size在我眼里 越来越抢眼，貌似有个api可以获取到资源加载~~~~~ 走起

```js
function getImgSize(url){
    return new Promise((res, rej) => {
        var performance = window.performance || 
            window.msPerformance || 
            window.webkitPerformance;
        if (performance) {
            const img = new Image()
            img.crossOrigin = ''
            img.onload = function() {
                let [imgEntries] = performance.getEntriesByName(url)
                res(imgEntries)
            }
            img.onerror = function() {
                rej('图片加载失败')
            }
            img.src = url
        }else{
            rej('浏览器不持支持performance')
        }
    })
}
let url = 'https://images.daojia.com/changsha/banner/pic/25675a8d10bfa08e9599d2deb9a44eae.jpeg'
getImgSize(url).then(v=>{
    console.log(v)
    console.log(v.decodedBodySize)
    console.log((v.decodedBodySize / 1000),'KB')
    // transferSize  判断是否缓存
})
```

> 这块使用 decodedBodySize，因为 css js等资源 decodedBodySize 与本地大小一致

[encodedBodySize-MDN 文档](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceResourceTiming/encodedBodySize)

[decodedBodySize-MDN 文档](https://developer.mozilla.org/en-US/docs/Web/API/PerformanceResourceTiming/decodedBodySize)

<YurImg src="https://cdn.jsdelivr.net/gh/HouJinlong/pic@master/2020-04-30/performance.png" alt="" />

> 咦~貌似真的可以，与本地完全一致 甚至比 和Network展示的还准确


## 多组数据

| 图片地址 | 本地size | canvas.toBlob | canvas.toDataURL  + dataURLtoBlob | performance |
| ------- | -------- | ------------- | --------------------------------- | ------------- |
| https://images.daojia.com/changsha/banner/pic/25675a8d10bfa08e9599d2deb9a44eae.jpeg     | 20519      |   36345         | 36343               | 20519       |
| https://images.daojia.com/dop/custom/dda52b42212b6bdea3e12d03ac97ffbe.png | 65511 | 164303 | 164302  | 65511 |
| https://images.daojia.com/dop/custom/f8f0528c61e243699c309f5f25eab513.png | 14638 | 36394 | 36391 | 14638 |

> 没有看错 performance 与本地的完全一样

## 不限制于图片

```js
function loadJSFile(source) {
    return new Promise((res, rej) => {
        const node = document.createElement('script')
        node.async = false
        node.src = source

        const supportOnload = 'onload' in node
        if (supportOnload) {
            node.onload = function(){
                res(this)
            }
            node.onerror = () => {
                rej(`${source}加载失败`)
            }
        } else {
            node.onreadystatechange = function(){
                if (/loaded|complete/i.test(node.readyState)) {
                    res(this)
                }
            }
        }
        document.getElementsByTagName('head')[0].appendChild(node)
    })
}
function loadImgFile(url){
    return new Promise((res, rej) => {
        const img = new Image()
        img.crossOrigin = ''
        img.onload = function() {
            res(this)
        }
        img.onerror = function() {
            rej('图片加载失败')
        }
        img.src = url
    })
}

function loadCSSFile(source) {
    return new Promise((res, rej) => {
        var head = document.getElementsByTagName('head')[0];
        var link = document.createElement('link');
        link.type = 'text/css';
        link.rel = 'stylesheet';
        link.href = source;
        const supportOnload = 'onload' in link
        if (supportOnload) {
            link.onload = function(){
                res(this)
            }
            link.onerror = () => {
                rej(`${source}加载失败`)
            }
        } else {
            link.onreadystatechange = function(){
                if (/loaded|complete/i.test(link.readyState)) {
                    res(this)
                }
            }
        }
        head.appendChild(link);
    })
}
function getFileSize(url){
    return new Promise((res, rej) => {
    var performance = window.performance || 
        window.msPerformance || 
        window.webkitPerformance;
    if (performance) {
        let [imgEntries] = performance.getEntriesByName(url)
        if(imgEntries){
            console.log(imgEntries)
            console.log(imgEntries.decodedBodySize)
            console.log((imgEntries.decodedBodySize / 1000),'KB')
            res(imgEntries)
        }else{
            rej('资源加载有问题')
        }
    }else{
        rej('浏览器不持支持performance')
    }
})
}
(async function (){
    const css = 'https://cdn.bootcdn.net/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css';
    await loadCSSFile(css)
    await getFileSize(css)

    const js = 'https://cdn.bootcdn.net/ajax/libs/vue/2.6.11/vue.min.js';
    await loadJSFile(js)
    await getFileSize(js)

    const img = 'https://images.daojia.com/dop/custom/f8f0528c61e243699c309f5f25eab513.png';
    await loadImgFile(img)
    await getFileSize(img)
})()
```

<YurImg src="https://cdn.jsdelivr.net/gh/HouJinlong/pic@master/2020-04-30/all.png" alt="" />

## 兼容性

作为一个优秀的前端，使用api必须考虑兼容性哇！[caniuse - performance](https://caniuse.com/#search=encodedBodySize) 有个不幸的消息，兼容性不怎么好




