FROM openorchestra/open-orchestra:oo-apache2.4-php5.6

COPY ./vhosts.conf /etc/apache2/sites-available/
COPY ./load.sh /

RUN a2ensite vhosts.conf

CMD ["/run.sh"]
