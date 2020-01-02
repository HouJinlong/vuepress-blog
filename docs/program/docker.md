---

title: docker

meta:

  - name: description

    content: docker安装

  - name: keywords

    content: docker,linux

date: 2019-12-30

update_date: 2019-12-30
 
tags: 

  - docker

  - linux


banner: http://ww1.sinaimg.cn/large/006I5hBxly1gaexm283ooj30dw0bkmyc.jpg
---

从这篇开始正式折腾我的云服务器了，首先开始docker,这是我在之前腾讯云时折腾过的应用容器引擎，虽然很菜但是我感觉它挺好，好在哪呢，下面是我从 [菜鸟教程](https://www.runoob.com/docker/docker-tutorial.html)中 粘贴的一句话

> Docker 可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化。容器是完全使用沙箱机制，相互之间不会有任何接口（类似 iPhone 的 app）,更重要的是容器性能开销极低。

- 可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中(小白可以直接下别人的应用包)
- 容器是完全使用沙箱机制，相互之间不会有任何接口(不会互相影响，对我这种小白友好)

## Docker

[菜鸟教程-CentOS Docker 安装](https://www.runoob.com/docker/centos-docker-install.html)

```bash
    # 设置 yum 源为阿里的
    sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    # 启动 Docker。
    sudo systemctl start docker 
    # 测试命令
    docker -v
```
## Docker-Compose

传统的`Docker`，一个容器需要一个`Dockerfile`来描述，如果说一个项目比较大，用到了较多的技术，就会有很多个容器，如果需要挨个执行 `Dockerfile`，甚至启动的时候也是挨个去启动，开发会累死，运维也会累死。`Docker-Compose`解决了这个问题，为每个项目提供一个描述文件，并且批处理项目中的所有容器。

1. 安装docker-compose

  ```bash
    curl -L https://get.daocloud.io/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
  ```
2.验证

  ```bash
    docker-compose -v
  ```

> 到此docker的安装已完成





