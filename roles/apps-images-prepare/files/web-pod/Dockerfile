FROM centos:centos7

RUN yum install -y httpd
RUN yum install -y postgresql python-psycopg2
RUN yum install -y which
RUN yum install -y pacemaker pacemaker-remote resource-agents

EXPOSE 80

# Start the service
#  use CMD so it can be overridden by pacemaker-remote
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
