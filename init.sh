#!/usr/bin/env bash

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

# Install node
nvm install 18.16.0

# Install pnpm
npm init -y \
  && npm i -g pnpm \
  && pnpm add -g pnpm \
  && pnpm config set store-dir ~/.pnpm-store \
  && rm -f node_modules \
  && rm -f package-lock.json \
  && pnpm i

# Install prettier
pnpm i -D prettier prettier-plugin-java prettier-plugin-kotlin prettier-plugin-packagejson \
  prettier-plugin-sh prettier-plugin-sql @prettier/plugin-xml

# Install husky
pnpm i -D husky && npm pkg set scripts.prepare="husky install" && pnpm prepare

# Configure Prettier lint-staged
pnpm i -D lint-staged \
  && npx husky add .husky/pre-commit "npx --no-install lint-staged" \
  && touch .lintstagedrc.js \
  && echo "module.exports = {" >> .lintstagedrc.js \
  && echo "  '*.{sh,js,jsx,ts,tsx,css,scss,md,html,java,kotlin,xml,sql,sh,json,package.json}': [" >> .lintstagedrc.js \
  && echo "    'prettier --plugin @prettier/plugin-xml --plugin prettier-plugin-sh  --write'," >> .lintstagedrc.js \
  && echo "  ]," >> .lintstagedrc.js \
  && echo "};" >> .lintstagedrc.js

# Install pre-commit-checks
pnpm i -D git-precommit-checks \
  && npx husky add .husky/pre-commit "npx --no-install git-pre-commit-checks" \
  && touch git-precommit-checks.config.js

# Install Commitlint
pnpm i -D @commitlint/{config-conventional,cli} \
  && npx husky add .husky/commit-msg "npx --no-install --no-config commitlint --edit \$1" \
  && echo "module.exports = {" >> commitlint.config.js \
  && echo "  extends: ['@commitlint/config-conventional']," >> commitlint.config.js \
  && echo "};" >> commitlint.config.js

# Install commitizen
npm i -g commitizen
pnpm i -D @commitlint/cz-commitlint commitizen --save-exac

# Install validate-branch-name
pnpm i -D validate-branch-name \
  && npx husky add .husky/pre-push "npx --no-install validate-branch-name"

# Init Gradle
gradle init
