---

title: Linux 基础命令

meta:

  - name: description

    content: Linux 基础命令

  - name: keywords

    content: sh,linux

date: 2019-12-20

update_date: 2019-12-20
 
tags: 

  - sh

  - linux

banner: http://ww1.sinaimg.cn/large/006I5hBxly1gafon462ipj30u00ifq3v.jpg
---

作为一个开发人员，我深刻认是到应该扎实一下`Linux 基础命令`,毕竟图形用户界面 (GUI)是给普通用户用的，高手都是命令行！一开始作为小白决定 命令行一点没有GUI方便，但是现在 emmmmmmmmmmmm 真香！

- [原文地址](https://juejin.im/post/5dd292ef518825638b753975)

## yum仓库

从一个前端开发人员来讲yum和npm很像,yum提供了查找、安装、删除某一个、一组甚至全部软件包的命令，而且命令简洁而又好记([yum菜鸟教程地址](https://www.runoob.com/linux/linux-yum.html))

### 1. 查询远程

| 命令               | 作用                    |
|------------------|-----------------------|
| yum search git   | 搜索某个软件名称或者描述的重要关键字    |
| yum info git     | 列出软件功能                |
| yum list         | 列出yum服务器上面所有的软件名称     |
| yum list updates | 列出yum服务器上可提供本机进行升级的软件 |

### 2. 安装/升级

```bash
yum install/update 软件名称 -y  // -y 安装过程中免输入y确认
```
### 3. 删除
```bash
yum remove 软件名称
```





    






