FROM ubuntu:latest

MAINTAINER Andre Fonseca <oandrefonseca@gmail.com>

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y nodejs
RUN apt-get install -y npm

##### Conda and R #####
# conda install -c anaconda mongodb 
# Reference: https://hub.docker.com/r/conda/miniconda3/dockerfile

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 \
    && conda update conda \
    && apt-get -qq -y remove curl bzip2 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes

ENV PATH /opt/conda/bin:$PATH

##### Install and setting MongoDB #####
# Reference: https://medium.com/dockerbr/mongodb-no-docker-dd3b72c7efb7

RUN conda install -c anaconda mongodb 
RUN conda install -c anaconda pymongo 

# Installing R and R-essentials

RUN conda install -c r r-base
RUN conda install -c r r-tidyverse

# Installing Flask

RUN conda install -c anaconda flask 

# Install Dash

# conda install -c conda-forge dash 
# conda install -c conda-forge/label/gcc7 dash 
# conda install -c conda-forge/label/cf201901 dash 

# Other Links and Information
# https://github.com/singingwolfboy/build-a-flask-api/tree/master/step07