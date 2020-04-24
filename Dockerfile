# Dockerfile for DeepMind Lab

#
# Setup Ubuntu
#
FROM ubuntu:18.04

RUN  apt-get update -y && \
     apt-get upgrade -y && \
     apt-get dist-upgrade -y && \
     apt-get -y autoremove && \
     apt-get clean

RUN apt-get install -y curl git gnupg zip unzip

# Set working directory
WORKDIR /deepmind-lab

#
# Install Bazel
#
RUN echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
  && curl https://bazel.build/bazel-release.pub.gpg | apt-key add -

RUN apt-get update \
  && apt-get install -y bazel \
  && rm -rf /var/lib/apt/lists/*

# Install JDK
# RUN apt-get install -y openjdk-11-jdk

#
# Install DeepMind Lab
#

# Install dependencies
RUN apt-get install -y \
  libffi-dev gettext freeglut3-dev libsdl2-dev \
  zip libosmesa6-dev python-dev python-numpy python-pil python3-dev \
  python3-numpy python3-pil

# Clone Deepmind Lab
RUN git clone https://github.com/deepmind/lab.git

WORKDIR /deepmind-lab/lab



