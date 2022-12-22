FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install -y git wget python3.9 build-essential \
    && apt-get clean && apt-get autoclean && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/eqasim-org/ile-de-france.git /srv/app/ile-de-france \
    && cd /srv/app/ile-de-france \
    && git checkout 51a0c37 \
    && cd /tmp \
    && wget https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u252-b09/OpenJDK8U-jdk_x64_linux_hotspot_8u252b09.tar.gz -O java.tar.gz \
    && mkdir $HOME/java \
    && tar -xf java.tar.gz -C $HOME/java \
    && wget http://mirror.easyname.ch/apache/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz -O maven.tar.gz \
    && mkdir $HOME/maven \
    && tar -xf maven.tar.gz -C $HOME/maven \
    && wget https://github.com/openstreetmap/osmosis/releases/download/0.48.2/osmosis-0.48.2.tgz -O osmosis.tgz \
    && mkdir $HOME/osmosis \
    && tar -xf osmosis.tgz -C $HOME/osmosis \
    && wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh \
    && bash miniconda.sh -b -p $HOME/miniconda

ENV PATH=/root/miniconda/bin:/root/osmosis/bin:/root/java/jdk8u252-b09/bin:/root/maven/apache-maven-3.6.3/bin:$PATH

RUN . "/root/miniconda/etc/profile.d/conda.sh" \
    && conda config --set always_yes yes --set changeps1 no \
    && conda update -q conda \
    && conda env create -f /srv/app/ile-de-france/environment.yml

RUN . "/root/miniconda/etc/profile.d/conda.sh" \
    && conda activate ile-de-france \
    && python3 --version && which python3 \
    && java -version && which java \
    && mvn -v && which mvn \
    && osmosis -v && which osmosis \
    && git --version

ENV PATH=/root/miniconda/envs/ile-de-france/bin:$PATH

RUN python3 --version && which python3 && echo $PATH \
    && mkdir -p /srv/app/input \
    && mkdir -p /srv/app/output \
    && mkdir -p /srv/app/data \
    && mkdir -p /srv/app/cache

COPY prepare_config.py data/template_lead.yml entrypont.sh /srv/app/
WORKDIR /srv/app

ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]
