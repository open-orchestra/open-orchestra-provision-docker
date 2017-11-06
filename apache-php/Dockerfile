FROM eboraas/debian:stretch

RUN apt-get update && apt-get -y install apache2 && apt-get clean && rm -rf /var/lib/apt/lists/*

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN /usr/sbin/a2ensite default-ssl
RUN /usr/sbin/a2enmod ssl

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

RUN apt-get update && apt-get install -y php7.0 php7.0-cli php7.0-common php7.0-curl php7.0-dev php7.0-gd php7.0-intl php7.0-mbstring php7.0-mcrypt libav-tools git && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y imagemagick libmagickwand-dev pkg-config && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN printf "\n" | pecl install mongodb
RUN printf "\n" | pecl install imagick
RUN printf "\n" | pecl install xdebug

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"


COPY ./vhosts/back-openorchestra-20.conf /etc/apache2/sites-available/back-openorchestra-20.conf
COPY ./vhosts/front-openorchestra-20.conf /etc/apache2/sites-available/front-openorchestra-20.conf
COPY ./vhosts/media-openorchestra-20.conf /etc/apache2/sites-available/media-openorchestra-20.conf

COPY ./ini/mongodb.ini /etc/php/7.0/mods-available/
COPY ./ini/imagick.ini /etc/php/7.0/mods-available/
COPY ./ini/symfony.ini /etc/php/7.0/mods-available/
COPY ./ini/xdebug.ini /etc/php/7.0/mods-available/

COPY ./cron/openorchestra /etc/cron.d/

RUN phpenmod mongodb
RUN phpenmod imagick
RUN phpenmod symfony
RUN phpenmod xdebug
RUN printf "\n"

RUN a2ensite back-openorchestra-20.conf
RUN a2ensite front-openorchestra-20.conf
RUN a2ensite media-openorchestra-20.conf

RUN usermod -u 1000 www-data
RUN chown www-data:www-data /var/www

ENV SYMFONY_WITH_DOCKER 1

EXPOSE 80

WORKDIR /var/www

CMD /usr/sbin/apache2ctl -D FOREGROUND
