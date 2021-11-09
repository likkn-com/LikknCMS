#
# LikknCMS Dockerfile
#
# https://github.com/likkn-com/LikknCMS
#

# Pull base image.
FROM node:14.16.1

WORKDIR /usr/src/app

COPY *.* ./
# Set environment variables.
ENV NODE_ENV production

# Install LikknCMS
RUN yarn install --pure-lockfile
RUN ./node_modules/knex-migrator/bin/knex-migrator init
RUN cd core/client
RUN NODE_ENV=development yarn install --pure-lockfile
RUN ./node_modules/ember-cli/bin/ember build -prod
RUN cd ../..

# Define mountable directories.
VOLUME ["/data"]

# Define default command.
CMD ["pm2-runtime", "index.js"]

# Expose ports.
EXPOSE 2368
