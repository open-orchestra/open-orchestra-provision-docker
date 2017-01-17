FROM eboraas/apache

RUN apt-get update && apt-get install -y php5 php5-cli php5-gd php5-curl php5-mcrypt php5-intl php5-dev php5-common libav-tools git && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y imagemagick libmagickwand-dev pkg-config && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN printf "\n" | pecl install mongo
RUN printf "\n" | pecl install imagick
RUN printf "\n" | pecl install xdebug

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"


COPY ./vhosts/back-openorchestra-20.conf /etc/apache2/sites-available/back-openorchestra-20.conf
COPY ./vhosts/front-openorchestra-20.conf /etc/apache2/sites-available/front-openorchestra-20.conf
COPY ./vhosts/media-openorchestra-20.conf /etc/apache2/sites-available/media-openorchestra-20.conf

COPY ./ini/mongo.ini /etc/php5/mods-available/
COPY ./ini/imagick.ini /etc/php5/mods-available/
COPY ./ini/symfony.ini /etc/php5/mods-available/
COPY ./ini/xdebug.ini /etc/php5/mods-available/

COPY ./cron/openorchestra /etc/cron.d/

RUN php5enmod mongo
RUN php5enmod imagick
RUN php5enmod symfony
RUN php5enmod xdebug
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
