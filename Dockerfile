FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NOWARNINGS="yes"

RUN apt-get -qq update \
&& apt-get install -y --no-install-recommends apt-utils \
clang-12 cmake git \
&& apt-get clean


EXPOSE 8000
ENTRYPOINT ["/bin/bash"]
