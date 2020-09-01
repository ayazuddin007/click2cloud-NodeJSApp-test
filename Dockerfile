FROM node:latest


# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
COPY package*.json ./

# If you are building your code for production
RUN npm install

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "npm", "start" ]
