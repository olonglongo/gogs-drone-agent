# 5分钟搭建CICD平台

## 1. 更换软件源 [ubuntu](https://mirror.tuna.tsinghua.edu.cn/help/ubuntu/)

```
cat << EOF > /etc/apt/sources.list
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-proposed main restricted universe multiverse
EOF
apt-get clean
apt-get update
```

## 2. 安装`docker` [docker](https://mirror.tuna.tsinghua.edu.cn/help/docker-ce/)
```
sudo apt-get remove -y docker docker-engine docker.io
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
```

## 3. 安装`docker-compose` [compose](https://docs.docker.com/compose/install/)
```
sudo curl -L "https://hub.fastgit.org/docker/compose/releases/download/1.28.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
docker-compose --version
```

## 4. 更新`docker`源
```
cat > /etc/docker/daemon.json << EOF
{
    "registry-mirrors": [
        "http://f1361db2.m.daocloud.io"
    ],
    "log-level": "warn",
    "live-restore": true
}
EOF
systemctl restart docker
```

## 5. 部署`CICD`
```
git clone https://hub.fastgit.org/olonglongo/gogs-drone-agent.git /opt/cicd
cd /opt/cicd
docker-compose up -d
```
