FROM oven/bun:latest
WORKDIR /usr/src/app

# Install Node.js and npm for npx support
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY package.json ./
RUN bun install --ignore-scripts --no-cache

COPY scripts ./scripts
COPY src ./src
COPY tsconfig.json .
RUN bun run build

EXPOSE 3000/tcp
ENTRYPOINT [ "npx", "-y", "supergateway", "--stdio", "bun run start" ]