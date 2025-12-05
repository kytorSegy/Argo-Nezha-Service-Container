FROM debian

WORKDIR /dashboard

# 安装依赖
RUN apt-get update &&\
    apt-get -y install openssh-server wget iproute2 vim git cron unzip supervisor nginx sqlite3 &&\
    git config --global core.bigFileThreshold 1k &&\
    git config --global core.compression 0 &&\
    git config --global advice.detachedHead false &&\
    git config --global pack.threads 1 &&\
    git config --global pack.windowMemory 50m &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/*

# 【核心修改】直接把本地修好的 init.sh 复制进去，不要去网上下载了！
COPY init.sh /dashboard/init.sh

# 给脚本执行权限
RUN chmod +x /dashboard/init.sh

# 启动命令
ENTRYPOINT ["/dashboard/init.sh"]
