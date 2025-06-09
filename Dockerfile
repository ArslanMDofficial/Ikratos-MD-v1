FROM node:lts-buster

# Install all required system dependencies (native modules ke liye)
RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp \
  build-essential \
  libcairo2-dev \
  libpango1.0-dev \
  libjpeg-dev \
  libgif-dev \
  librsvg2-dev \
  python3 \
  && apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy dependency manifests
COPY package.json package-lock.json* ./

# Clean cache & install dependencies
RUN npm cache clean --force
RUN npm install --verbose

# (Optional) Global module install (but better to avoid this if local works)
# RUN npm install -g qrcode-terminal

# Copy app code
COPY . .

# Expose the port (only if needed)
EXPOSE 5000

# Default command
CMD ["node", "index.js", "--server"]
