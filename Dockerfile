FROM node:lts-alpine
RUN npm i -g serve
WORKDIR /app
COPY ./ .
COPY package*.json ./
RUN npm install
RUN npm run build 
EXPOSE 3000
CMD ["serve","-s","dist"]