#PHP 7.1 with PDO MySQL/MariaDB support
=======================================

This is an [image](https://hub.docker.com/r/vertedge/php/) based on the [php 7.1-fpm-alpine](https://hub.docker.com/_/php/) image which adds PDO support for MySQL/MariaDB.
Below is a sample docker-compose.yml file which launches a MariaDB, PHP-FPM (FastCGI Process Manager), Nginx and MailHog stack.

Build scripts and sample usage can be found on [github](https://github.com/wytzevanderploeg/docker/tree/master/php7-mod-mysql).

```docker
version: '2'
services:
  mariadb:
    image: mariadb:10.3.0
    ports:
     - "127.0.0.1:3306:3306"
    volumes:
     - mariadb_data:/var/lib/mysql
    environment:
     MYSQL_ROOT_PASSWORD: rootpassword
     MYSQL_DATABASE: sample
     MYSQL_USER: sample
     MYSQL_PASSWORD: sample

  php-fpm:
    depends_on:
     - mariadb
     - mailhog
    image: vertedge/php:7.1.7-fpm-alpine-mod-mysql
    volumes:
     - .:/application
     - ./php-ini-overrides.ini:/etc/php/7.1/fpm/conf.d/99-overrides.ini
#    ports:
#     - "127.0.0.1:9000:9000"

  nginx:
    depends_on:
     - php-fpm
    image: nginx:alpine
    working_dir: /application
    volumes:
     - .:/application
     - ./nginx.conf:/etc/nginx/conf.d/default.conf
    ports:
     - "127.0.0.1:8080:80"

  mailhog:
    image: mailhog/mailhog:latest
    ports:
#     - "127.0.0.1:1025:1025"
     - "127.0.0.1:8025:8025"

volumes:
  mariadb_data:
```
