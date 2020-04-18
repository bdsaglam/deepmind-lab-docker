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

RUN apt-get install -y git

# Set working directory
WORKDIR /deepmind-lab

#
# Install Bazel
#

# Install packages required by Bazel
RUN apt-get install -y g++ unzip zip

# Install JDK
# RUN apt-get install -y openjdk-11-jdk

# Copy and run binary installer
ENV bazel_installer bazel-3.0.0-installer-linux-x86_64.sh
COPY /${bazel_installer} . 

RUN chmod +x ${bazel_installer}
RUN ./${bazel_installer} --user
RUN echo 'export PATH="$PATH:$HOME/bin"' >> ~/.bashrc

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
RUN bazel build -c opt //:deepmind_lab.so


