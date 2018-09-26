FROM centos:centos7

ADD initdb.sh /
ADD init.sql /

RUN yum install -y postgresql-server
RUN yum install -y which
RUN yum install -y pacemaker pacemaker-remote resource-agents
