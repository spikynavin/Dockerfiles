Dockerfiles for ubuntu distro

Dockerfiles available for build below list distro.

1. Ubuntu-16.04
2. Ubuntu-18.04
3. Ubuntu-20.04

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

Note: before execute the above cmd export the variables with proper values.