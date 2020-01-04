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

## 安装

### docker

[菜鸟教程-CentOS Docker 安装](https://www.runoob.com/docker/centos-docker-install.html)

```bash
    # 设置 yum 源为阿里的
    sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
    # 启动 Docker。
    sudo systemctl start docker 
    # 测试命令
    docker -v
```
### Docker-Compose

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

## docker基础命令

| 命令         | 作用         |
| -------------- | -------------- |
| docker version | 查看版本   |
| docker --help  | 帮助         |
| docker info    | 显示Docker信息 |

## 镜像命令

### 列出本地主机上的镜像

```bash
docker images
```
同一仓库源可以有多个 TAG，代表这个仓库源的不同个版

参数：

- `docker images -a` 列出本地所有的镜像（包括中间映像层）
- `docker images -q` 只显示镜像ID
- `docker images --digests` 显示镜像的摘要信息
- `docker images --no-trunc` 显示完整的镜像信息

| REPOSITORY       | TAG        | IMAGE ID | CREATED      | VIRTUAL SIZE |
| ---------------- | ---------- | -------- | ------------ | ------------ |
| 表示镜像的仓库源 | 镜像的标签 | 镜像ID | 镜像创建时间 | 镜像大小 |

### 从Docker Hub查找镜像

```bash
docker search 镜像名
```

参数：

- `docker search --automated 镜像名` 只列出 automated build类型的镜像
- `docker search --no-trunc 镜像名`  显示完整的镜像描述
- `docker search -s 20 镜像名`  列出收藏数不小于指定值的镜像

| NAME       | DESCRIPTION     | STARS   | OFFICIAL |  AUTOMATED |
| ---------------- | ---------- | -------- | ------------ | ------------ |
| 镜像仓库源的名称 | 镜像的描述 | 收藏数 | 否docker官方发布 | 是否automated build类型的镜像 |

### 下载镜像

```bash
docker pull 镜像名 
# 等价于
docker pull 镜像名:latest
```

### 删除镜像

```bash
docker rmi 镜像名

# 强制删除
docker rmi -f 镜像名

# 删除多个
docker rmi -f 镜像名1:TAG 镜像名2:TAG

# 删除全部
docker rmi -f $(docker images -qa)
```

## 容器命令

[菜鸟教程](https://www.runoob.com/docker/docker-container-usage.html)

### 新建并启动容器

`docker run` 当本地不存在 `IMAGE` 镜像时会 先下载 后运行

```bash
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
```

options说明:

  - `--name="容器新名字"`：为容器指定一个名称
  - `-d`：后台运行容器，并返回容器ID，即启动守护式容器
  - `-i`：以交互模式运行容器,允许你对容器内的标准输入 (STDIN) 进行交互。配合-t使用
  - `-t`：为容器重新分配一个伪输入终端 配合-i使用
  - `-P`：指定端口映射

***

实例:

```bash
# 以下命令使用 ubuntu 镜像启动一个容器，参数为以命令行模式进入该容器
docker run -it ubuntu /bin/bash
# 要退出终端，直接输入 exit
```
参数说明：
- `-i`: 交互式操作。
- `-t`: 终端。
- `ubuntu`: ubuntu 镜像。
- `/bin/bash`：放在镜像名后的是命令，这里我们希望有个交互式 Shell，因此用的是 /bin/bash。

### 列出容器

```bash
docker ps [options]
```

options，参数说明：

- `docker ps -l` 显示最近创建的容器
- `docker ps -a` 显示所有容器（默认仅显示正在运行）
- `docker ps -n 5` 显示最近5个创建的容器
- `docker ps -q` 只显示容器编号
- `docker ps --no-trunc` 不截断输出

### 退出容器

```bash
# 容器停止退出
exit

# 容器不停止退出
ctrl+P+Q
```

### 启动容器

```bash
docker start 容器名/容器id
```

### 重启容器

```bash
docker restart 容器名/容器id
```

### 停止容器

```bash
docker stop 容器名/容器id
```

### 强制停止容器

```bash
docker kill 容器名/容器id
```
### 删除已停止的容器

```bash
docker rm 容器id

# 一次性删除多个容器
docker rm -f $(docker ps -a -q)
docker ps -a -q | xargs docker rm
```
### 查看容器日志

```bash
docker logs -f -t --tail 容器id
```

参数说明:

- `-t`：加入时间戳
- `-f`：跟随最新的日志打印
- `--tail`: 数字：显示最后多少条

### 查看容器内运行的进程

```bash
docker top 容器id
```


### 查看容器内部细节

```bash
docker inspect 容器id
```

### 进入正在运行的容器并以命令行交互

```bash
# exec 在容器中打开新的终端，并且可以启动新的进程
docker exec -it 容器id bash  

# 或

# attach 直接进入容器启动命令的终端，不会启动新的进程
docker attach 容器id
```

### 从容器和主机直接互相 拷贝文件

容器路径加前缀 ` 容器id:`

```bash
# 拷贝容器文件到 主机
docker cp 容器id:容器内路径 目的主机路径

# 拷贝主机文件到 容器
docker cp 目的主机路径 容器id:容器内路径 
```

### 从容器创建一个新的镜像

```bash
docker commit [OPTIONS] 容器id 目标镜像名:[标签名]
```

常用选项:

- `-a` :提交的镜像作者；
- `-c` :使用Dockerfile指令来创建镜像；
- `-m` :提交时的说明文字；
- `-p` :在commit时，将容器暂停。
















