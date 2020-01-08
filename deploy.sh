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

time=$(date)
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
git commit -m "$time"

# 强制推送到 cnguu.github.io 仓库的 master 分支
git push -f git@github.com:HouJinlong/houjinlong.github.io.git master

cd ../

# 删除 dist_temp 文件夹
rm -fr dist

# 备份文档
git add .

git commit -m "$time"

git push
# 结束
echo 'done'
