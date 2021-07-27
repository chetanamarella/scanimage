  
FROM nginx 

MAINTAINER chetana

RUN apt-get update

COPY ./index.html /usr/share/nginx/html/index.html
