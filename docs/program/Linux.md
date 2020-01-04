---

title: Linux 

meta:

  - name: description

    content: Linux 

  - name: keywords

    content: linux

date: 2020-01-04

update_date: 2020-01-04
 
tags: 

  - linux

banner: http://ww1.sinaimg.cn/large/006I5hBxly1gakptmh3jyj30m806y3yi.jpg
---

我们开发出来的程序一般都是放在Linux下运行的，Windows同样是操作系统，为啥要放在Linux下，而不放在Windows下呢？？因为linux有以下优点：

1. 免费

2. 很多软件原生是在Linux下运行的，庞大的社区支持，生态环境好。

3. 开源，可被定制，开放，多用户的网络操作系统。

4. 相对安全稳定

## linux基础

### Linux系统的组成

1. linux内核（linus 团队管理）

2. shell：用户与内核交互的接口

3. 文件系统：ext3、ext4等。windows 有 fat32  、ntfs

4. 第三方应用软件

### Shell的基本知识

> Shell是系统的用户界面，提供了用户与内核进行交互操作的一种接口(命令解释器)

Shell可以执行：

- 内部命令

- 应用程序

- shell脚本

![undefined](http://ww1.sinaimg.cn/large/006I5hBxly1gakpzmoezzj30e30d1aa8.jpg)


使用`type`命令可以区分内部命令和外部命令
```bash
type cd
# cd is a shell builtin

type tree
# tree is /usr/bin/tree

chmod +x demo.sh
./demo.sh
```

