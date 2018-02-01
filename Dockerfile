#
#   A simple Dockerfile for integration testing against AMQ7
#

FROM centos:latest

MAINTAINER Todd Baert <tbaert@redhat.com>

USER root

# Download dependencies for downloading, and running AMQ7
RUN yum -y --nogpgcheck \
    install java-1.8.0-openjdk \
    libaio \
    wget \
    unzip

# Download and unzip AMQ7
RUN wget -q http://apache.claz.org/activemq/activemq-artemis/2.4.0/apache-artemis-2.4.0-bin.zip
RUN unzip apache-artemis-2.4.0-bin.zip

# create a broker instance with no security
RUN apache-artemis-2.4.0/bin/artemis create --user test --password password --allow-anonymous testbroker

# Expose web console
EXPOSE 8161

# Expose AMQP and AMQPS
EXPOSE 5672
EXPOSE 5671

# Run the broker instance
ENTRYPOINT testbroker/bin/artemis run
