# use latest alpine as base
FROM alpine:latest

# determine nginx version to use
ARG version

# install php and supervisor
RUN apk --no-cache add pcre-dev supervisor php7 php7-fpm

# configure php-fpm
COPY fpm-pool.conf /etc/php7/php-fpm.d/www.conf

# configure php
COPY php.ini /etc/php7/conf.d/custom.ini

# configure supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# copy nginx binary
COPY nginx /usr/sbin/nginx

# create client body temp path
RUN mkdir -p /usr/share/nginx/tmp

# add nginx user
RUN adduser www-data -D -H

# expose nginx port
EXPOSE 80

# run nginx and php in supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
