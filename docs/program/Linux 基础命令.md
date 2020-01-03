---

title: Linux 基础命令

meta:

  - name: description

    content: Linux 基础命令

  - name: keywords

    content: sh,linux

date: 2019-12-28

update_date: 2020-01-02
 
tags: 

  - sh

  - linux

banner: http://ww1.sinaimg.cn/large/006I5hBxly1gafon462ipj30u00ifq3v.jpg
---

作为一个开发人员，我深刻认是到应该扎实一下`Linux 基础命令`,毕竟图形用户界面 (GUI)是给普通用户用的，高手都是命令行！一开始作为小白决定 命令行一点没有GUI方便，但是现在 emmmmmmmmmmmm 真香！

## yum:仓库

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

## grep：查找文件中的关键字
```bash
grep "string" [选项] file
```
使用grep命令查找文件中的所有React关键字:

![undefined](http://ww1.sinaimg.cn/large/006I5hBxly1gaibyoj3fcj30oq09a3yw.jpg)

[选项]用法：

![undefined](http://ww1.sinaimg.cn/large/006I5hBxly1gaibzgod9oj30zk0m9wgd.jpg)

## cat：查看文件的内容

cat 可以 创建有内容的文件，查看整个文件，合并文件，拷贝文件

| 命令               | 作用                    |
|------------------|-----------------------|
| cat filename   | 一次显示整个文件    |
| cat > filename     | 创建一个文件，并将前面命令的输出内容填充进去                |
| cat file1 file2 > file      | file1 和 file2 合并为 file     |
| cat file1 > file  | 拷贝file1 为file |

## tail：查看文档的内容

`tail`命令在查看崩溃报告或以前的历史记录日志时很有用,默认显示文档的最后 10 行

```bash
tail [选项] somefile
```

选项:

- `-f` 循环读取。`tail -f notes.log`

复制代码此命令显示 notes.log 文件的最后 10 行。当将某些行添加至 notes.log 文件时，tail 命令会继续显示这些行。 显示一直继续，直到您按下（Ctrl-C）组合键停止显示。
- `-n` 最后xx行。`tail -n 10 notes.log`
复制代码显示文件 notes.log 的内容，文件末尾10行。

## find: 搜索文件

find命令可以快速查找文件或目录。当你正在处理具有数百个文件和多个目录的大型项目时，此功能很有用

```bash
find path -name filename
```

例子：

1. 查找当前目录下所有index.js `find . -name index.js`
2. 查找当前目录下所有js文件 `find . -name "*.js"`
3. 查找当前目录下文件夹中有-log的文件夹 `find . -name "*-log"`

## mv：移动文件
`mv` 命令将文件或目录从一个位置移动到另一个位置。

```bash
mv somefile /to/some/other/path
```

## rm：删除文件/目录

`rm`命令用于删除一个文件或者目录。

```bash
rm [选项] someFile
```
选项：
- `-i` 删除前逐一询问确认。
- `-f` 即使原档案属性设为唯读，亦直接删除，无需逐一确认。
- `-r` 将目录及以下之档案亦逐一删除。

## tree：以树状图列出目录的内容

常在写文档时需要列一下文件目录结构，这个时候`tree`命令就能帮个忙了。如果没有`tree`命令便可用`yum`安装
```bash
yum install tree -y
```

## | ：管道命令

通常情况下，我们在终端只能执行一条命令，然后按下回车执行，那么如何执行多条命令呢？

顺序执行多条命令：`command1;command2;command3;` 简单的顺序指令可以通过` ;`来实现。

有条件的执行多条命令：`which command1 && command2 || command3`

  `&&` : 如果前一条命令执行成功则执行下一条命令，和JavaScript中用法一致

  `||` :与&&命令相反，执行不成功时执行下一个。

  `$?`: 存储上一次命令的返回结果

```bash
which git>/dev/null && git --help  // 如果存在git命令，执行git --help命令
echo $? 
```

而管道命令则可以衔接各种命令的输出输入，使得连锁操作变得简单。

> 管道是一种通信机制，通常用于进程间的通信（也可通过socket进行网络通信），它表现出来的形式将前面每一个进程的输出（stdout）直接作为下一个进程的输入（stdin）

![undefined](http://ww1.sinaimg.cn/large/006I5hBxly1gaie5ldlphj30je05njra.jpg)

```bash
指令1 | 指令2 | …
```

管道命令的注意事项：
 - 只能处理前一条指令的正确输出，不能处理错误输出；
 - 后一条指令，必须能够接收标准输入流命令才能执行。
 
例子：
  1. 分页显示 /etc 目录 中内容的详细信息
  ```bash
  ls -l /etc | more
  ```
  2. 将一个字符串输入到一个文件中
  ```bash
  echo "Hello World" | cat > hello.txt
  ```
![undefined](http://ww1.sinaimg.cn/large/006I5hBxly1gaie11bc1hj31ao2as7ss.jpg)







    






