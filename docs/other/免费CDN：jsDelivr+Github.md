---

title: 免费CDN：jsDelivr+Github

meta:

  - name: description

    content: 免费CDN：jsDelivr+Github

  - name: keywords

    content: 测试，文章

date: 2020-01-09

update_date: 2020-01-09
 
tags: 

  - Github

banner: http://ww1.sinaimg.cn/large/006I5hBxly1gaqcdvvvpqj30us0fy754.jpg
---

故事还是起源于 今天早餐时看到的那篇文章，我从[gh-pages](../tools/gh-pages.md)联想到这个博客主题作者写过的[https://gleehub.com/other/shi-yong-forestry-guan-li-ji-yu-github-de-tu-chuang.html](使用 Forestry 管理基于 GitHub 的图床) (我使用的微博图床感觉很方便) 最后的又好奇 图片cdn规则 `https://cdn.jsdelivr.net/gh/....` 于是有了这篇记录

## jsdelivr

可以反向代理任意的 github、npm 文件，而且国内也有 CDN 节点，速度非常快。 [https://www.jsdelivr.com/](https://www.jsdelivr.com/)

对应使用规则 网站首页有，这里说点别的

### 访问对应 branch 的文件

```
https://github.com/HouJinlong/pic/blob/master/demo1.png

对应的jsdelivr地址 

https://cdn.jsdelivr.net/gh/HouJinlong/pic@master/demo1.png

```

- `HouJinlong/pic` git仓库地址
- `master` 要访问的文件分支
- `demo1.png` 要访问的文件地址

::: tip
这种是直接访问某分支的文件，图床使用这种方式比较方便
:::


### 访问对应 tag 的文件


```
https://github.com/HouJinlong/pic/blob/2.0/demo1.png

对应的jsdelivr地址 

https://cdn.jsdelivr.net/gh/HouJinlong/pic@2.0/demo1.png

最新 tag 对应的 文件地址
https://cdn.jsdelivr.net/gh/HouJinlong/pic/demo1.png

所有tag的 文件展示页面
https://cdn.jsdelivr.net/gh/HouJinlong/pic/

```
- `HouJinlong/pic` git仓库地址
- `tag` 要访问的文件tag
- `demo1.png` 要访问的文件地址
```

## 参考jquery

### github

[地址](https://github.com/jquery/jquery/releases)

[对应 jsdelivr ](https://cdn.jsdelivr.net/gh/jquery/jquery/)

### npm 

[地址](https://www.npmjs.com/package/jquery)

[对应 jsdelivr](https://cdn.jsdelivr.net/npm/jquery/)




