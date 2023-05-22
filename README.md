```Dockerfiles for ubuntu distro for yocto-buildsystem

We are using docker container as a host env for yocto bulildsystem.

At master branch ubuntu-16.04 dockerfiles are available.

The following packages are included in the image are.

gawk \
wget \
git-core \
diffstat \
unzip \
texinfo \
gcc-multilib \
g++-multilib \
build-essential \
chrpath \
socat \
cpio \
rpm2cpio \
xz-utils \
debianutils \
iputils-ping \
libegl1-mesa \
libsdl1.2-dev \
lzop \
liblz4-tool \
libssl-dev \
lib32z1-dev \
libelf-dev \
xterm \
locales \
vim \
bash-completion \
screen \
texlive-full \
libterm-readkey-perl \
intltool \
xalan \
software-properties-common \
openssl \
groff-base \
cmake \
gnupg \
gnupg2 \
apt-utils \
sudo \
curl \
squashfs-tools \
gprbuild \
make \
xsltproc \
docbook-utils \
fop \
dblatex \
xmlto \
realpath \
subversion \
cvs \
dos2unix \
net-tools \
iproute2 \
u-boot-tools \
bc \
protoc

List of Python-Packages

python \
python-pkg-resources \
python-msgpack \
python-setuptools
python3 \
python3-pip \
python3-pkg-resources \
python3-pexpect \
python3-git \
python3-jinja2 \
python3-msgpack \
python3-setuptools

Java support packages

openjdk-8-jdk

Perforce-client packages

helix-cli
_____________________________________________________________________________________________________________________________

Command to build the distro from dockerfile.

$ docker build -t (imagename):(tag name) .

These docker images are genric one so, we need to pass the passwd and group then only it can able to fetch the user info from the host machine.

For that we are providing the below docker run cmd.

To generate the passwd and group file:

echo $USER:x:$(id -u):$(id -g):$USER:$HOME:/bin/bash > passwd
echo $USER:x:$(id -g):$USER > group

docker run --rm \
                --entrypoint $(pwd)/yocto-entrypoint.sh \
                -v $(pwd)/passwd:/etc/passwd \
                -v $(pwd)/group:/etc/group \
                -v $HOME:$HOME \
                -v $workdir:$workdir \
                -e $HOME \
                -e USER=$USER \
                -e branch=$branch \
                -e workdir=$workdir \
                -u $(id -u):$(id -g) \
                -w $workdir \
                -i $dockerimage

Note: before execute the above cmd export the variables with proper values```.