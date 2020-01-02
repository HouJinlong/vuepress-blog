---
title: lftp上传工具

meta:

  - name: description

    content: lftp上传工具

  - name: keywords

    content: ftp,sh

date: 2019-12-20

update_date: 2019-12-20
 
tags: 

  - ftp

  - sh

banner: http://ww1.sinaimg.cn/large/006I5hBxly1gaejs7e9u3j30aj097dg7.jpg
---

> 前几天写上线代码同步测试环境脚本时，需要上传文件到ftp,之前都是走js(vinyl-ftp),这次既然用sh脚本了，于是发现了这个好用的库，顺带做个记录

```
#!/bin/sh
dir=$1
ftp_dir=$2
ip=xx.xx.31.219
port=21
user=[用户名]
pwd=[密码]

# 连接
lftp -u $user,$pwd -p $port $ip <<EOF    
# 把$dir(本地目录)的东西都上传到$ftp_dir(远程目录)
mirror -R "$dir" "$ftp_dir"

# 结束连接
bye
EOF
echo "ftp done"
```
## windows 使用 lftp

[网盘下载地址](https://pan.baidu.com/s/1uQlCzVbOcL1uQlOMjaKF1Q)  [原文地址](https://caibaoz.com/blog/2013/04/10/lftp-for-windows/)

> 安装完成后 环境变量里边添加 xxxx\xxxx\lftp-4.4.8\bin,重启终端窗口 便可以运行lftp命令了

![sp20191230_113215_638.png](http://ww1.sinaimg.cn/large/006I5hBxly1gaelcfbweaj30qb0h5jrt.jpg)

## lftp使用

[原文地址](https://blog.csdn.net/fjb2080/article/details/7758486)

> 大多数图形界面的 ftp客户端，都有两栏窗口，一栏为本地目录，一栏为远程目录。lftp 也采用这种方式工作，只不过没有使用图形界面直观的显示

![sp20191230_121524_422.png](http://ww1.sinaimg.cn/large/006I5hBxly1gaepjearuvj30o3061mx2.jpg)

- 其中， ! 表示执行本地命令，lftp中没有与 ls 对应的本地命令 lls， 所以要使用 !ls 显示本地目录文件

> 使用以上命令确认当前工作目录的情况。以下命令用于从本地目录上传，或者从远程目录下载：

![sp20191230_135754_749.png](http://ww1.sinaimg.cn/large/006I5hBxly1gaepjyogt0j30oc067q2u.jpg)

>在远程目录中，可以使用以下命令操作文件

![sp20191230_135838_645.png](http://ww1.sinaimg.cn/large/006I5hBxly1gaepkshjqvj30o005l0sn.jpg)

>使用 exit 命令退出 lftp

## 注意

### window路径
window本地路径 前面要增加/cygdrive

### sftp 和 ftp 默认端口号

| sftp        |  ftp           | 
| ------------- | -----:|
| 22    | 21 | 

> 默认的可不写，但是不能写错，同时呢,如果其他的sftp服务器的端口号修改之后,可以通过-P来指定要通过哪个端口号连接.

### window上传文件异常

::: danger
【暂未解决】window上传的文件夹 无法删除 响应：550 Remove directory operation failed
:::

