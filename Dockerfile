# This is the default configuration that the globalmouth/apache24 image was based off

#Loads the apache2.4 image from Docker Hub
FROM globalmouth/apache24

#Create some folders where we link our local repositories
#RUN mkdir /var/www
#RUN mkdir /var/www/git
#RUN mkdir /usr/local/apache2/conf/sites-enabled
#RUN chmod 0755 /var/www/

#Copy the Apache configuration file to the Virtual machine
#COPY apache/httpd.conf /usr/local/apache2/conf/httpd.conf

