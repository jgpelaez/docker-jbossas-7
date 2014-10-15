# Docker base image for jboss As 7 #


## Build ##

### Build behind a proxy ##

For building this image behind a proxy, you can execute:

	bash build.sh
	
It will pass the local variables http_proxy to a generated DockerFile,
build the image, run an instance, remove the ENV variables and do the commit.
