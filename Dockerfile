FROM node:18-alpine
WORKDIR /usr/src/app

COPY package*.json ./

ARG NPM_TOKEN

RUN echo "registry=https://registry.npmjs.org/" > .npmrc \
 && echo "//registry.npmjs.org/:_authToken=${NPM_TOKEN}" >> .npmrc \
 && npm ci \
 && rm .npmrc

COPY . .

CMD ["npm", "start"]
