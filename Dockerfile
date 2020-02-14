# Dockerfile from here: https://nodejs.org/de/docs/guides/nodejs-docker-webapp/

FROM node:10-alpine

# Create app directory
WORKDIR /myapp

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are
# copied where available (npm@5+)
COPY package*.json ./
# COPY package.json ./


RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 3000
CMD ["node", "app.js"]
