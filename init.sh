#!/usr/bin/env bash

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Install node
nvm install 18.16.0

# Install pnpm
npm init -y && \
npm i -g pnpm && \
pnpm add -g pnpm && \
pnpm config set store-dir ~/.pnpm-store && \
rm -f node_modules && \
rm -f package-lock.json && \
pnpm i

# Install prettier
pnpm i -D prettier prettier-plugin-java prettier-plugin-kotlin prettier-plugin-packagejson \
prettier-plugin-sh prettier-plugin-sql @prettier/plugin-xml

# Install husky
pnpm i -D husky
pnpm prepare
