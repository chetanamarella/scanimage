FROM ubuntu

MAINTAINER chetana

RUN sudo apt-get update

RUN sudo apt-get install -y openjdk-8-jdk

RUN sudo apt-get install -y docker.io

RUN sudo systemctl start docker

RUN sudo systemctl enable docker  
