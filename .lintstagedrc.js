module.exports = {
  '*.{sh,js,ts,css,scss,md,html,java,xml,sql,json,package.json}': [
    'prettier --plugin @prettier/plugin-xml --plugin prettier-plugin-sh  --write',
  ],
};
