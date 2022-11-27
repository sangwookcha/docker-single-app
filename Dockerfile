FROM node:alpine as builder
WORKDIR /usr/src/app
COPY --chown=node:node package.json ./
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build

FROM nginx
RUN rm -rf /etc/nginx/conf.d
COPY conf /etc/nginx
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
CMD ["nginx", "-g", "daemon off;"]
