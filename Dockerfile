# Thani Cloud
# Author : Thani
# Copyright (c) 2017 

FROM google/dart:1.24 AS build
MAINTAINER "Thani<thaniyarasu@gmail.com>"

RUN mkdir /app
WORKDIR /app
ADD pubspec.yaml pubspec.yaml
ADD pubspec.lock pubspec.lock
RUN pub get
COPY . /app
RUN pub build
#CMD ["pub","serve","-b","0.0.0.0","-p","8080"]

FROM nginx:latest
COPY --from=build /app/build/web /usr/share/nginx/html
