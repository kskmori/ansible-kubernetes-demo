FROM centos:centos7

RUN yum install -y httpd
RUN yum install -y postgresql python-psycopg2
RUN yum install -y which
RUN yum install -y pacemaker pacemaker-remote resource-agents

ADD action /var/www/cgi-bin/action
RUN echo "PassEnv POSTGRES_PORT_5432_TCP_ADDR" >> /etc/httpd/conf/httpd.conf
RUN echo "PassEnv POSTGRES_SERVICE_SERVICE_HOST" >> /etc/httpd/conf/httpd.conf
RUN chown root:apache /var/www/cgi-bin/action
RUN chmod 755 /var/www/cgi-bin/action
RUN echo "The Web Server is Running" > /var/www/html/index.html
EXPOSE 80

# Start the service
CMD ["-D", "FOREGROUND"]
ENTRYPOINT ["/usr/sbin/httpd"]
