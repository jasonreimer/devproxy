FROM nginx:latest
MAINTAINER Mike Heijmans <parabuzzle@gmail.com>

ENV API_HOST localhost
ENV API_PORT 8080
ENV UI_HOST localhost
ENV UI_PORT 3000
ENV SERVER_NAME localhost
ENV API_PATH /api

COPY ./scripts/nginx.conf.template /etc/nginx/nginx.conf.template
COPY ./scripts/run.sh /run.sh

RUN chmod +x /run.sh

CMD ["/run.sh"]
