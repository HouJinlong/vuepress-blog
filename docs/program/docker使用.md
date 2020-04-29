---

title: docker的使用

meta:

  - name: description

    content: docker的使用

  - name: keywords

    content: docker,linux

date: 2020-04-23

update_date: 2020-04-23
 
tags: 

  - docker

  - linux


banner: http://ww1.sinaimg.cn/large/006I5hBxly1gaexm283ooj30dw0bkmyc.jpg
---

> 统一使用 Docker-Compose 方式来启动，比起纯命令行的，我更喜欢docker-compose.yml记录，这样过很久也能很清楚知道

## docker-compose.yml 使用

[Docker Compose菜鸟教程文档](https://www.runoob.com/docker/docker-compose.html)

```
# 关闭容器
docker-compose stop;
# 删除容器
docker-compose down;
# 构建镜像
docker-compose build;
# 启动并后台运行
docker-compose up -d;
# 查看日志
docker logs jenkins;
# 对空间进行自动清理
docker system prune -a -f

```

## 实践

[https://github.com/HouJinlong/docker-demo](https://github.com/HouJinlong/docker-demo)

### jenkins

1.编写 docker-compose.yml

[https://github.com/HouJinlong/docker-demo/blob/master/jenkins/docker-compose.yml](https://github.com/HouJinlong/docker-demo/blob/master/jenkins/docker-compose.yml)

2.运行,ip+端口访问，根据提示找到管理员登录密钥，等待安装插件....

> 这块之前做的 忘记做笔记了









