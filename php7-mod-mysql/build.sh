#!/bin/bash

BASEDIR=$(dirname "$0")
echo "Building in this directory: $BASEDIR"

svn export --force https://github.com/docker-library/php/trunk/7.1/fpm/alpine php-7.1-fpm-alpine
sed -i 's/ENV PHP_EXTRA_CONFIGURE_ARGS/ENV PHP_EXTRA_CONFIGURE_ARGS --with-pdo-mysql/' "$BASEDIR/php-7.1-fpm-alpine/Dockerfile"

# Determine full version number
VERSION=$(grep 'ENV PHP_VERSION' php-7.1-fpm-alpine/Dockerfile | cut -d ' ' -f 3)
echo "Building version: $VERSION"

docker build -t "vertedge/php:$VERSION-fpm-alpine-mod-mysql" "$BASEDIR/php-7.1-fpm-alpine"
