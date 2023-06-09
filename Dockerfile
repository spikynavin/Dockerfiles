FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

# make /bin/sh symlink to bash instead of dash:
RUN echo "dash dash/sh boolean false" | debconf-set-selections \
&& dpkg-reconfigure dash

RUN apt-get update && apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib \
g++-multilib build-essential chrpath socat cpio rpm2cpio xz-utils debianutils iputils-ping libegl1-mesa \
libsdl1.2-dev lzop liblz4-tool libssl-dev lib32z1-dev libelf-dev xterm locales vim bash-completion screen \
texlive-full libterm-readkey-perl intltool xalan software-properties-common openssl groff-base cmake gnupg \
gnupg2 apt-utils sudo curl squashfs-tools gprbuild make xsltproc docbook-utils fop dblatex xmlto \
realpath subversion cvs dos2unix net-tools iproute2 u-boot-tools bc

RUN apt-get update && apt-get install -y python python-pkg-resources python-msgpack python-setuptools

RUN apt-get update && apt-get install -y python3 python3-pip python3-pkg-resources python3-pexpect python3-git python3-jinja2 \
python3-msgpack python3-setuptools

RUN add-apt-repository ppa:openjdk-r/ppa \
&& apt-get update && apt-get install -y openjdk-8-jdk

RUN curl "https://bootstrap.pypa.io/pip/2.7/get-pip.py" -o /"get-pip.py" && python /get-pip.py

RUN echo "deb http://package.perforce.com/apt/ubuntu $(lsb_release -cs) release" > /etc/apt/sources.list.d/perforce.list

ADD ./requirements.txt /requirements.txt

RUN python -m pip install --trusted-host pypi.python.org -r /requirements.txt

RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add - \
&& apt update && apt install -y helix-cli

RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip -P / \
&& unzip -o /protoc-3.0.0-linux-x86_64.zip -d /usr/local bin/protoc && unzip -o /protoc-3.0.0-linux-x86_64.zip -d /usr/local 'include/*' \
&& chmod +x /usr/local/bin/protoc

RUN apt-get update && dpkg-reconfigure locales \
&& locale-gen en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

ENV LANG en_US.utf8

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /requirements.txt /get-pip.py /protoc-3.0.0-linux-x86_64.zip