# install dependencies for build phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# run phase (new FROM ends previous block -> builder)
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html