FROM node:alpine as builder
WORKDIR '/usr/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
## Expose is meant for aws beanstalk to do port mapping automatically. This will not 
## work on our local environment
EXPOSE 80
## copy build output of previous step from /usr/app/build directory
COPY --from=builder /usr/app/build /usr/share/nginx/html
## The base image of nginx already has startup command configured. we no need to do it here.