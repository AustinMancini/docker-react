# Production Dockerfile

#install all depend. and run "npm build"
FROM node:alpine as builder

WORKDIR '/app'
COPY ./package.json ./
RUN npm install
COPY . .

# second phase
FROM nginx
EXPOSE 80

# copy over build folder to nginx container were putting together
COPY --from=builder /app/build /usr/share/nginx/html

# /app/build <--- folder with all the stuff we care about that we want to
# copy over during our run phase