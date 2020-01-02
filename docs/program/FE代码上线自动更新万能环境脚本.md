---

title: FE代码上线自动更新万能环境脚本

meta:

  - name: description

    content: FE代码上线自动更新万能环境脚本

  - name: keywords

    content: sh,npm,linux

date: 2019-12-20

update_date: 2019-12-20
 
tags: 

  - sh

  - npm

  - linux

banner: http://ww1.sinaimg.cn/large/006I5hBxly1gaeps07le3j310m0gnmy3.jpg
---

## 背景

> 前段时间公司项目都从jenkins 迁移 到djoy,但是同步【万能测试环境】的方案有问题了，需要调整，于是改为

![sp20191230_141235_093.png](http://ww1.sinaimg.cn/large/006I5hBxly1gaepz9rm60j30kr03daa5.jpg)

## 监听gitlab web

[gitlab项目 Settings] - [Webhooks]

![sp20191230_141846_136.png](http://ww1.sinaimg.cn/large/006I5hBxly1gaeq5oa0h4j30z80f2gmz.jpg)

## hook信息

> hook信息存放指定目录json，文件不入库因为比较简单，所以一切从简

```json
{
  "object_kind": "push",   
  "event_name": "push", // 本次hook事件
  "before": "67e3f0bee10ef5d4c2a8cbcc5d3a28c07db9681f",
  "after": "73ca64bb992eee4234b0f86f60e1431d06e865ae",
  "ref": "refs/heads/master",  // 本次提交分支
  "checkout_sha": "73ca64bb992eee4234b0f86f60e1431d06e865ae",
  "message": null,
  "user_id": 1151,
  "user_name": "�����",
  "user_email": "xxxxxxx",  // 提交人信息
  "user_avatar": "xxxxx",
  "project_id": 8206,
  "project": {   // 项目信息
    "name": "xxx",
    "description": "",
    "web_url": "http://git.xxx-inc.com/xxxx/xxx",
    "avatar_url": null,
    "git_ssh_url": "git@git.xxx.com:xx/xxx.git",
    "git_http_url": "http://git.xxx-inc.com/xxx/xxx.git",
    "namespace": "xxxx",
    "visibility_level": 0,
    "path_with_namespace": "xxx/xxx",
    "default_branch": "master",
    "homepage": "http://git.xxx-inc.com/xxx/xxx",
    "url": "git@git.xxx-inc.com:xxx/xxx.git",
    "ssh_url": "git@git.xx-inc.com:xxx/xxx.git",
    "http_url": "http://git.xxx-inc.com/xxx/xxx.git"
  },
  "commits": [  // push 的 commits信息
    ....
  ],
  "total_commits_count": 3,
  "repository": {
    "name": "xxx",
    "url": "git@git.xxx-inc.com:xxx/xxx.git",
    "description": "",
    "homepage": "http://git.xxx-inc.com/xxx/xxx",
    "git_http_url": "http://git.xxx-inc.com/xxx/xxx.git",
    "git_ssh_url": "git@git.xxx-inc.com:xxx/xxx.git",
    "visibility_level": 0
  }
}
```

## sh脚本

[upload_to_ftp.sh/上传脚本](lftp.md)

```bash
#!/bin/sh
# FE项目master更新 测试环境代码更新部署 脚本

# 开始
set -e

root_dir=$1 # 操作目录
git_ssh_url=$2 # 项目ssh
id=$3 # 项目 id
deploy_dir=$4 # 部署ftp路径

dirs=(A B C D E F G rd default) # 测试环境ftp目录

upload_to_ftp_path=$(pwd)/sh/upload_to_ftp.sh

# 进入root目录
cd $root_dir

if [ ! -d "$id" ];then
    git clone "$git_ssh_url" "$id"
    cd "$id"
else
    cd "$id"
    git pull --force
fi

sudo npm install --unsafe-perm

npm run build:test

# 上传
for dir in ${dirs[@]}
do
    sh "$upload_to_ftp_path" "$(pwd)"/dist "$dir""$deploy_dir"
done

cd ../

rm -fr dist

echo "deploy done"

```
> sudo npm install --unsafe-perm , 这块需要注意一下，开发的时候开发环境没有问题，部署正式，npm install一致失败，刚开始试着 给文件夹加权限，给脚本加权限，更换node执行sh脚本的api都不行，最后测试到这块才好，到现在也没搞清除为什么开发环境没问题，正式环境就不行，后续搞懂了补上

## node child_process.exec

```js
const cmd = `sh sh/deploy.sh .....`
const child = exec(cmd, {
    encoding: 'utf8', // 输出内容格式 
    detached: true,   // 用来让主进程不等待
    stdio: 'ignore'   // 用来让主进程不等待
}, (error, stdout, stderr) => {
   error:执行中报错
   stdout:执行输出
   stderr:执行错误信息
})
child.unref()   // 用来让主进程不等待

```

## 期间学习到的其他东西

