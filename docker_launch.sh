#!/bin/sh

docker_build() {
	echo "docker build -t hackathon ."
}

docker_run() {
	# PORT NAME VOLUME
	echo "docker run -it ${1} ${2} ${3}"
}

if [ "$1" = "build" ]; then
    echo "Building container"
    docker_build
else
	while getopts p:n:v: option
		do
			case "${option}"
				in
				p) PORT=${OPTARG};;
				n) NAME=${OPTARG};;
				v) VOLUME=${OPTARG};;
			esac
		done
	echo "Running container ${PORT} ${NAME} ${VOLUME}"
	docker_run $PORT $NAME $VOLUME
fi