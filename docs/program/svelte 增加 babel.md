---

title: svelte 增加 babel

meta:

  - name: description

    content: svelte 增加 babel

  - name: keywords

    content: svelte，babel，文章

date: 2019-12-02

update_date: 2019-12-02
 
tags: 

  - svelte

  - babel

  - package.json

banner: http://ww1.sinaimg.cn/mw690/006I5hBxly1g9imki2aw9j31hc0u014a.jpg
---


> 前情提要：同事做的一个 `svelte` 调研项目，增加babel时一直有问题，而且同事有别的项目排着比较忙，领导让我帮忙看看，好嘛走起，一顿操作，解决了，顺带了解了一些之前没注意的姿势，在这做个记录！

## babel-loader 
注意俩点：
```json
const babelLoaderConfig = {
	loader: 'babel-loader',
	options: {
		presets: [['@babel/preset-env', {
			targets: ['> 1%', 'last 2 versions', 'ie >= 9'],
			useBuiltIns: 'entry'
		}]]
	}
}
{
	test: /\.(m?js)$/,
	use:[babelLoaderConfig],
	exclude: /node_modules\/(?!svelte)/,  
}
```
### 1. exclude
`svelte` 包是未编译过的(打开看一下就知道)，需要对它也编译一下
### 2. test
 `svelte` 包的package.json 都指定了` "module": "./index. mjs"`，例如(node_modules\svelte\internal\package.json) 所以需要对 mjs文件也进行编译
 
 备注: 这块之前没注意，看源码的时候发现 文件都有俩份`.js `和`.mjs` 于是修改源码增加调试代码发现，都走了 `.mjs` ，然后去了解了下 [原因(文章地址)](https://segmentfault.com/a/1190000014286439 "原因(文章地址)")，
 
## babel配置
>上面问题已经解决了，这块是 同事临时提了一句，babel的配置我已经写在 `.babelrc` 是否不用写 options 了？嗯，应该是，去掉， 报错..... 很奇怪啊，why

### 
修改 `node_modules\babel-loader\lib\index.js`
```javascript
...
const config = babel.loadPartialConfig(injectCaller(programmaticOptions));
console.log('config',config) //增加的
if (config) {
	...
```
重新构建，查看输出
[![http://ww1.sinaimg.cn/large/006I5hBxly1g9ijldxkrcj313409t0vd.jpg](http://ww1.sinaimg.cn/large/006I5hBxly1g9ijldxkrcj313409t0vd.jpg "http://ww1.sinaimg.cn/large/006I5hBxly1g9ijldxkrcj313409t0vd.jpg")](http://ww1.sinaimg.cn/large/006I5hBxly1g9ijldxkrcj313409t0vd.jpg "http://ww1.sinaimg.cn/large/006I5hBxly1g9ijldxkrcj313409t0vd.jpg")

项目文件有，`node_modules`里的没有，我好像明白什么，打开[babel网站果然有说到 希望编译 node_modules 目录下的模块要用 babel.config.js ](https://www.babeljs.cn/docs/configuration "babel网站")

增加 `babel.config.js` 重新构建，虽然`.babelrc` 可能没有 但是 `babel.config.js`是全部都有的，且是同一份

[![http://ww1.sinaimg.cn/large/006I5hBxly1g9ijuy9z5cj30z2094acm.jpg](http://ww1.sinaimg.cn/large/006I5hBxly1g9ijuy9z5cj30z2094acm.jpg "http://ww1.sinaimg.cn/large/006I5hBxly1g9ijuy9z5cj30z2094acm.jpg")](http://ww1.sinaimg.cn/large/006I5hBxly1g9ijuy9z5cj30z2094acm.jpg "http://ww1.sinaimg.cn/large/006I5hBxly1g9ijuy9z5cj30z2094acm.jpg")
