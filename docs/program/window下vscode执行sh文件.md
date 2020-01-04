---

title: window下执行sh文件

meta:

  - name: description

    content: window下执行sh文件

  - name: keywords

    content: sh，文章

date: 2019-11-21

update_date: 2019-11-21
 
tags: 

  - sh

  - git

  - vscode

banner: http://ww1.sinaimg.cn/large/006I5hBxly1g95n8csg5lj30i008vdgh.jpg
---

> 使用过linux都知道sh脚本的方便，但是window cmd不支持linux语法，无法运行sh脚本

## Git工具来打开运行.sh脚本文件

安装git的时候会附带~Git bash~与~Git GUI~ 工具

![sp20191121_142634_187.png](http://ww1.sinaimg.cn/large/006I5hBxly1g95n8csg5lj30i008vdgh.jpg)

~Git bash~ 中使用 sh xxx.sh 文件可以运行 sh脚本

![sp20191121_142851_002.png](http://ww1.sinaimg.cn/large/006I5hBxly1g95nafkvvhj30fm09eweb.jpg)

每次允许都1.打开~Git bash~ 2.输入运行命令运行sh脚本 太繁琐，可以通过设置文件打开方式来通过双击默认调用~Git bash~运行sh脚本

![sp20191121_143301_243.png](http://ww1.sinaimg.cn/large/006I5hBxly1g95neizkiuj30jg0ak0ts.jpg)

## VsCode + Git bash

上面的虽然可以做到运行sh脚本，但是开发中还是太繁琐，能否通过编辑器直接运行sh脚本呢，那当然是可以啦！

### 设置Git bash为默认终端

[VsCode设置]-[功能]-[终端]

![sp20191121_143934_425.png](http://ww1.sinaimg.cn/large/006I5hBxly1g95nlbtx6mj30lg035mx8.jpg)

```
"terminal.integrated.shell.windows": "xxx\\Git\\bin\\bash.exe" //Git bash路径
```

### 修改 项目 package.json

script中增加调用sh脚本的命令

![sp20191121_144316_360.png](http://ww1.sinaimg.cn/large/006I5hBxly1g95np6m4gdj30e202omx2.jpg)

此时通过VsCode一键启动NPM脚本功能便可直接调用Git bash启动sh脚本

![sp20191121_150140_663.png](http://ww1.sinaimg.cn/large/006I5hBxly1g95ocjtyq7j30vz07qq42.jpg)





