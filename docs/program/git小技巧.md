---
title: git小技巧

meta:

  - name: description

    content: git小技巧

  - name: keywords

    content: git

date: 2020-01-08

update_date: 2020-01-08
 
tags: 

  - git

banner: http://ww1.sinaimg.cn/large/006I5hBxly1gap0z6pwllj30lm0dyt8x.jpg
---

记录一些感觉实用的git小技巧

## 本地代码与远程仓库关联

```bash
# 本地创建仓库 默认在 master分支
git init
# 添加远程仓库(origin) 地址为 git@github.com:HouJinlong/houjinlong.github.io.git
git remote add origin git@github.com:HouJinlong/houjinlong.github.io.git
git add .
git commit
# 将本地仓库的 master与 远程仓库(origin) 的master做关联并推送
git push -u origin master
```

## 本地仓库更换远程地址

### 直接改

```bash
# 查看本地仓库 关联的 远程仓库
git remote 
# echo origin
# 查看 远程仓库（origin）地址
git remote get-url origin
# 修改 远程仓库（origin）地址
git remote set-url origin git@github.com:HouJinlong/houjinlong.github.io.git
```

### 先删后改

```bash
# 查看本地仓库 关联的 远程仓库
git remote 
# echo origin
# 删除 远程仓库（origin）
git remote remove origin
# 添加远程仓库(origin) 地址为 git@github.com:HouJinlong/houjinlong.github.io.git
git remote add origin git@github.com:HouJinlong/houjinlong.github.io.git
# 将本地仓库的 master与 远程仓库(origin) 的master做关联并推送
git push -u origin master
```

### 直接修改配置文件

```bash
# vs打开 本地仓库git的配置
code .git/config
# 直接修改 url
[remote "origin"]
    url = origingit@github.com:HouJinlong/houjinlong.github.io.git
    fetch = +refs/heads/*:refs/remotes/origin/*
```

## git pull发生冲突，想舍弃本地分支

标题描述不太清除，这是我在工作中遇到的一种情况，本地分支与远程有冲突，git pull 的时候 需要解决冲突，但有时候不想要本地的修改了，自己是用这俩种方式实现的

1. 新建起一个项目，拉取远程代码(缺点需要再次安装依赖)
2. 远程分支 替换 本地分支
```bash
git checkout -b temp
git branch -D del_br
git checkout -b del_br origin/del_br
git branch -D temp
```

## 指令别名


[Beyond Compare - 网盘下载地址](https://pan.baidu.com/s/1rBlKZTLr_jinLomLWk-aBw)       

[原文地址](https://www.cnblogs.com/Erik_Xu/p/5655525.html)

指令别名就是给一些常用的指令设置一个较短的指令别名来提高Git的使用效率。

### .gitconfig

.gitconfig是配置的主要文件，它一般在`用户名`目录中，如果没有，可以通过以下两步创建：

1. 打开 Git Bash

2. 执行设置用户名或者设置邮箱的指令
```
# 设置用户名：
git config --global user.name "｛your username｝"
设置邮箱：
git config --global user.email "｛your email｝"
```
### 配置

```bash
# 使用 vs 打开
code ~/.gitconfig
```

#### 在.gitconfig 文件中增加 `别名配置`

```bash
[alias]
    st = status
    ci = commit
    co = checkout
    br = branch
    df = diff
    dft = difftool --dir-diff --no-symlinks
    dfs = diff --staged
    dfts = difftool --staged --dir-diff --no-symlinks
    mr = merge
    mrt = mergetool
    last = log -1 HEAD
    ls = log --oneline --graph --all --decorate
    lg = log --oneline --graph --all --decorate --pretty=format:"%h%x20%Cgreen%d%x20%Cred%an%x20%C(yellow)%ad%x20%Creset%s" --full-history --date=short
    rb = rebase -i
    cp = cherry-pick
```
#### 在.gitconfig 文件中增加 `Beyond Compare的配置`

命令行自带的文件差异比较工具功能比较简单，用来查看或对比文件差异时，可能效果不太好，特别是在解决冲突的时候，集成一些比较强大的差异比较工具 `Beyond Compare`

```bash
[diff]
    tool = bc4
[difftool]
    prompt = true
[difftool "bc4"]
    cmd = \"D:/Program Files/Beyond Compare 4/bcomp.exe\" "$(cygpath -w $LOCAL)" "$REMOTE"
[merge]
    tool = bc4
[mergetool]
    prompt = true
[mergetool "bc4"]
    cmd = \"D:/Program Files/Beyond Compare 4/bcomp.exe\" "$LOCAL" "$REMOTE" "$BASE" "$MERGED"
```

::: tip
Windows系统打开Beyond Compare 4，提示已经超出30天试用期限制，解决方法：

1. 输入命令 regedit 呼起注册表
2. 删除项目: 计算机\HKEY_CURRENT_USER\Software\Scooter Software\Beyond Compare 4CacheId
:::