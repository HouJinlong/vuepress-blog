---

title: 问题汇总

meta:

  - name: description

    content: 问题汇总

  - name: keywords

    content: 问题

date: 2020-04-02

update_date: 2020-04-02
 
tags: 

  - 问题

banner: http://ww1.sinaimg.cn/large/006I5hBxly1gaqcdvvvpqj30us0fy754.jpg
---

> 总结一下 遇到过的问题

## npm下载的全局包无法使用

1. 背景：从别的部门交接过来一个小程序项目，使用 [min-cli](https://github.com/meili/min-cli)
2. 问题：已经完成 环境安装，但是提示 `'min' 不是内部或外部命令，也不是可运行的程序或批处理文件。`
3. 解决：[原文](https://www.cnblogs.com/mzzz/p/11863597.html)
  1. `npm list -g --depth=0` 查看npm全局包的路径，和有哪些安装包
  2. 把第一步输出的全局包的路径 （例如下图中的C:\Users\daojia\.npm-global），加入到环境变量即可

![下图](https://cdn.jsdelivr.net/gh/HouJinlong/pic@master/2020-04-08/下图.png)

