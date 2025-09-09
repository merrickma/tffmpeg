# 使用基于ubuntu的Node.js镜像，指定版本22-slim
FROM node:22-slim

# 设置工作目录
WORKDIR /app

# 安装系统依赖和工具
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    fonts-liberation \
    fonts-wqy-zenhei \
    fonts-wqy-microhei \
    libappindicator3-1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcairo2 \
    libcups2 \
    libdbus-1-3 \
    libexpat1 \
    libfontconfig1 \
    libgbm1 \
    libgcc1 \
    libgdk-pixbuf2.0-0 \
    libglib2.0-0 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libstdc++6 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxkbcommon0 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    xdg-utils \
    xauth \
    fonts-noto-color-emoji \
    build-essential \
    libvips-dev \
    software-properties-common \
    curl \
    gnupg \
    || apt-get install -y --fix-missing \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 下载并安装FFmpeg 6.x静态构建版本
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget xz-utils && \
    cd /tmp && \
    wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz && \
    mkdir -p ffmpeg && \
    tar -xf ffmpeg-release-amd64-static.tar.xz -C ffmpeg --strip-components=1 && \
    cp ffmpeg/ffmpeg ffmpeg/ffprobe /usr/local/bin/ && \
    chmod +x /usr/local/bin/ffmpeg /usr/local/bin/ffprobe && \
    rm -rf /tmp/ffmpeg* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 验证FFmpeg版本
RUN ffmpeg -version | head -n 1

# 设置Puppeteer环境变量
ENV PUPPETEER_ARGS=--no-sandbox,--disable-setuid-sandbox

# 创建用于存储临时文件的文件夹
RUN mkdir -p /app/tempfiles

# 暴露端口（假设服务监听 3000，需根据实际调整）
EXPOSE 3000

# 容器启动时的默认命令
CMD ["bash"]