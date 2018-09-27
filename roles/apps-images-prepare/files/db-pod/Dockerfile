FROM centos:centos7
USER root

ADD initdb.sh /
ADD init.sql /
RUN chmod a+x /initdb.sh

RUN yum install -y postgresql-server
RUN yum install -y which
RUN yum install -y pacemaker pacemaker-remote resource-agents

ENV PGDATA /var/lib/pgsql/data

ENTRYPOINT ["/initdb.sh"]
CMD ["runuser", "postgres", "-c", "postgres"]
