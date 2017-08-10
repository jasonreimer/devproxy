#!/bin/bash

cd /etc/nginx && \
  sed s/{{SERVER_NAME}}/$SERVER_NAME/g nginx.conf.template \
  | sed s/{{API_HOST}}/$API_HOST/g \
  | sed s/{{API_PORT}}/$API_PORT/g \
  | sed s/{{UI_HOST}}/$UI_HOST/g \
  | sed s/{{UI_PORT}}/$UI_PORT/g \
  | sed 's|{{API_PATH}}|'$API_PATH'|g' \
  > /etc/nginx/conf.d/default.conf

nginx -g 'daemon off;'
