#
# LikknCMS Dockerfile
#
# https://github.com/likkn-com/LikknCMS
#

# Pull base image.
FROM node:14.16.1-stretch-slim

ENV NODE_ENV production

WORKDIR /usr/src/app
COPY ./ /usr/src/app
RUN pwd && ls && yarn install && ./node_modules/knex-migrator/bin/knex-migrator init && cd core/client && NODE_ENV=development yarn install && ./node_modules/ember-cli/bin/ember build -prod && cd ../.. && npm install -g pm2

# Define default command.
CMD ["pm2-runtime", "index.js"]

# Expose ports.
EXPOSE 2368
