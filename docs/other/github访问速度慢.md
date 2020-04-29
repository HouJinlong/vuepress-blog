---

title: github访问速度慢

meta:

  - name: description

    content: 问题

  - name: keywords

    content: github , 问题

date: 2020-04-10

update_date: 2020-04-10
 
tags: 

  - 问题

  - github

banner: http://ww1.sinaimg.cn/large/006I5hBxly1gdovlfsmzxj30hs0990t3.jpg
---

> 之前的 vpn 过期了,今天打开github的时候加载很慢，而且css和样式都加载失败，于是 向网友请教了一下果然有办法！

[https://zhuanlan.zhihu.com/p/93436925](https://zhuanlan.zhihu.com/p/93436925)

## 1. 修改本地hosts文件

```
windows系统的hosts文件的位置如下：C:\Windows\System32\drivers\etc\hosts
mac/linux系统的hosts文件的位置如下：/etc/hosts
```

## 2. 增加http://github.global.ssl.fastly.net和http://github.com的映射

获取Github相关网站的ip
访问 [https://www.ipaddress.com](https://www.ipaddress.com)，拉下来，找到页面中下方的“IP Address,Domain or Hostname” 
分别输入github.global.ssl.fastly.net和github.com，查询ip地址

下面是我的配置
```
140.82.112.4 github.com
199.232.69.194 github.global.ssl.fastly.net
```

## 清除DNS缓存

```
windows下刷新DNS的方法: 打开CMD 输入 ipconfig /flushdns
```



