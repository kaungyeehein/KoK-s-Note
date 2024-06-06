# Docker & Docker Swarm

<div style="text-align: right;">KaungYeeHein's Note<br/>2024-Jun-6</div>

## Table of Contents
- [Chapter 1: Get Info](#chapter-1-get-info)
---

## Chapter 1: Apps Deployment

1. Traditional Deployment
2. Virtualized Deployment
3. Container Deployment
4. Kubernetes Deployment

---

## Chapter 2: Apps Architecture

1. Monolithic Architecture
2. Microservices Architecture
	- Microservices on VMs
		- Type 1 hypervisors, called “bare metal,” run directly on the host’s hardware. Ex: Microsoft Hyper-V or VMware ESXi hypervisor
		- Type 2 hypervisors, called “hosted,” run as a software layer on an operating system. Ex: VirtualBox, VMware Player, KVM
	- Microservices with Containers
		- Docker Containers

---

## Chapter 3: Basic Command

Docker Home: /var/lib/docker
```shell
docker version
docker info

docker pull [ubuntu]
docker image ls
docker image rm [image]

docker run nginx

docker container ls -a
docker container start [container]
docker container stats [container]
docker container stop [container]
docker container rm [container]
docker container inspect [container]

docker network ls
docker network rm [network]

docker volume ls
docker volume rm [volume]

docker history [image]
```

---

## Chapter 4: Create Sample Container

Can change in Container
```shell
docker run -detach -p 8080:80 --name webhost nginx
docker exec -it webhost bash
docker commit webhost [new-image]
```

---

## Chapter 5: Create Customs Network

Can ping with hostname
```shell
docker network create --driver bridge my-net
docker run -d -it --name c1 --net my-net kunchalavikram/ubuntu_with_ping
docker run -d -it --name c2 --net my-net kunchalavikram/ubuntu_with_ping
```

---

## Chapter 6: Create Sample Volume

Named Volume: Mounting a volume created using ‘docker volume create’ command and mounting it from default volume location /var/lib/docker/volumes
```shell
docker volume create my-vol
docker run -d --name nginx -v myvol:/app nginx
docker run -d --name nginx --mount source=myvol2,target=/app nginx
```

Bind Volume: External mounting (external hard disks etc). Bind mounts may be stored anywhere on the host system. They usually start with ‘/’
```shell
docker run –name web -v /root/html:/var/www/html/ nginx
```

---

## Chapter 7: Dockerfile

- `FROM` defines the base image used to start the build process
- `MAINTAINER` defines a full name and email address of the image creator
- `COPY` copies one or more files from the Docker host into the Docker image
- `EXPOSE` exposes a specific port to enable networking between the container and the outside
world
- `RUN` runs commands while image is being built from the dockerfile and saves result as a new
layer
- `VOLUME` is used to enable access from the container to a directory on the host machine
- `WORKDIR` used to set default working directory for the container
- `CMD` command that runs when the container starts
- `ENTRYPOINT` command that runs when the container starts

Dockerfile
```dockerfile
FROM python:alpine3.7 
COPY . /app
WORKDIR /app
RUN pip install flask 
EXPOSE 5000
CMD python ./app.py
```

app.py
```PY
import socket
from flask import Flask 
def getIP():
	hostname = socket.gethostname()
	s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM) s.connect(("8.8.8.8", 80))
	ip = s.getsockname()[0]
	print(ip)
	s.close()
	return hostname,ip
app = Flask(__name__) @app.route("/")
def hello():
	hostname,ip = getIP()
	out = "Hello from hostname: " + hostname + " with host ip: " + ip 
	return out
if __name__ == "__main__": 
	app.run(host="0.0.0.0", port=int("5000"), debug=True)
```

`docker build -t flaskapp .`