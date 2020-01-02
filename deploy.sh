#!/usr/bin/env bash
#
# VuePress 通用部署脚本
#
# Windows 无法执行 .sh 文件，需要安装 git 客户端
#
# Author: cnguu
# Email: www@cnguu.cn
#

# 开始
set -e

# 编译
# package.json 中需要有这一句："build": "vuepress build docs"
npm run build

# 复制 README.md 文件到 dist_temp 文件夹
cp -i README.md dist

# 进入 dist_temp 目录
cd dist

# 初始化仓库
git init

# 添加
git add -A

# 提交
git commit -m deploy

# 强制推送到 cnguu.github.io 仓库的 master 分支
git push -f git@github.com:HouJinlong/houjinlong.github.io.git master

# 多仓库部署开始 ------

# 删除 CNAME
#rm CNAME

# 新建 CNAME 文件，并写入 www.gleehub.com 域名
#echo www.gleehub.com > CNAME

# 添加
#git add -A

# 提交
#git commit -m deploy

# 强制推送到 cnguu.coding.me 仓库的 master 分支
#git push -f git@git.dev.tencent.com:cnguu/cnguu.coding.me.git master

# 多仓库部署结束 ------

# 返回上一级目录
cd ../

# 删除 dist_temp 文件夹
rm -fr dist

# 结束
cd -