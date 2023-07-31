#!/bin/sh

# Substitute the NGINX_PORT placeholder in the config file with the actual value
sed -i "s/{{HOST_PORT}}/$HOST_PORT/g" /etc/nginx/conf.d/default.conf

# Start Nginx
nginx -g "daemon off;"
