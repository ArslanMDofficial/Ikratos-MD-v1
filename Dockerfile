FROM node:lts-buster

RUN apt-get update && \
  apt-get install -y ffmpeg imagemagick webp && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json package-lock.json* ./

RUN npm cache clean --force
RUN npm install --verbose
RUN npm install -g qrcode-terminal

COPY . .

EXPOSE 5000

CMD ["node", "index.js", "--server"]
