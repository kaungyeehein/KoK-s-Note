# Docker & Docker Swarm

<div style="text-align: right;">KaungYeeHein's Note<br/>2024-Jun-6</div>

## Table of Contents

- [Chapter 1: Apps Deployment](#chapter-1-apps-deployment)
- [Chapter 2: Apps Architecture](#chapter-2-apps-architecture)
- [Chapter 3: Basic Command](#chapter-3-basic-command)
- [Chapter 4: Create Sample Container](#chapter-4-create-sample-container)
- [Chapter 5: Create Customs Network](#chapter-5-create-customs-network)
- [Chapter 6: Create Sample Volume](#chapter-6-create-sample-volume)
- [Chapter 7: Dockerfile](#chapter-7-dockerfile)
- [Chapter 8: Docker Compose](#chapter-8-docker-compose)
- [Chapter 9: Docker Swarm](#chapter-9-docker-swarm)
- [Chapter 10: Docker Stacks](#chapter-10-docker-stacks)
- [Chapter 11: HAProxy LoadBalancer](#chapter-11-haproxy-loadbalancer)

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

docker pull <ubuntu>
docker image ls
docker image rm <image>

docker run nginx

docker container ls -a
docker container start <container>
docker container stats <container>
docker container stop <container>
docker container rm <container>
docker container inspect <container>

docker network ls
docker network rm <network>

docker volume ls
docker volume rm <volume>

docker history <image>
```

---

## Chapter 4: Create Sample Container

Can change in Container
```shell
docker run -detach -p 8080:80 --name webhost nginx
docker exec -it webhost bash
docker commit webhost <new-image> # Create new image from current container
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

Build Image
```
docker build -t flaskapp .
```

---

## Chapter 8: Docker Compose

docker-compose.yml
```yml
version: '3.3' 
services:
	wordpress:
		image: wordpress 
		depends_on:
			- mysql ports:
			- 8080:80 
		environment:
			WORDPRESS_DB_HOST: mysql 
			WORDPRESS_DB_NAME: wordpress 
			WORDPRESS_DB_USER: wordpress 
			WORDPRESS_DB_PASSWORD: wordpress
		volumes:
			- ./wordpress-data:/var/www/html
		networks: 
			- my-net
	mysql:
		image: mariadb 
		environment:
			MYSQL_ROOT_PASSWORD: wordpress 
			MYSQL_DATABASE: wordpress 
			MYSQL_USER: wordpress 
			MYSQL_PASSWORD: wordpress
		volumes:
			- mysql-data:/var/lib/mysql
		networks: 
			- my-net

volumes: 
	mysql-data:

networks: 
	my-net:
```

Build Image
```shell
docker-compose build
docker-compose up -d
docker-compose down
docker-compose down -v # To delete all data run:
docker-compose ps
```

---

## Chapter 9: Docker Swarm

Container Orchestration, Load balancing & High availability 

Master Node
```shell
docker swarm init --advertise-addr <MANAGER_IP>
```

Worker Node
```shell
docker swarm join --token SWMTKN-1-3kabuqlekspyqdk02vj0strami9mcysj8lw4klp5cwmh3wm4ej-
9rlom6m90chce1tgi0ke58t4l <MANAGER_IP>:2377
```

Command
```shell
docker node ls
docker node update --availability drain <node> # Terminate workloads on node
docker node update --availability active <node>

docker network ls | grep overlay

docker service create --replicas 5 -p 80:80 --name web nginx
docker service create --replicas 5 -p 80:5000 --name web kunchalavikram/sampleflask:v2

docker service ls
docker service ps <service>
docker service ps <node>
docker service scale web=3 # Scale down

docker service update --image nginx:1.18 --update-parallelism 2 --update-delay 10s web # Rolling update
docker service update --rollback <service> # Rollback update

docker service update --force <service>	# Force workload balance
docker service rm <service>
```

Docker Swarm Visualizer
```shell
docker service create \
	--name=viz \
	--publish=8080:8080/tcp \
	--constraint=node.role==manager \
	--mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
	dockersamples/visualizer
```

---

## Chapter 10: Docker Stacks

Docker Stacks is Production grade docker-compose.

compose.yml
```yml
version: '3.3' 
services:
	wordpress:
		image: wordpress 
		depends_on:
			- mysql 
		ports:
			- 80:80
		deploy:
			replicas: 2 
			placement:
				constraints:
					- node.role == manager
		environment:
			WORDPRESS_DB_HOST: mysql 
			WORDPRESS_DB_NAME: wordpress 
			WORDPRESS_DB_USER: wordpress 
			WORDPRESS_DB_PASSWORD: wordpress
		volumes:
			- wordpress-data:/var/www/html
		networks: 
			- my-net
	mysql:
		image: mariadb 
		deploy:
			replicas: 1 
			placement:
				constraints:
					- node.role == worker
		environment: 
			MYSQL_ROOT_PASSWORD: wordpress 
			MYSQL_DATABASE: wordpress 
			MYSQL_USER: wordpress 
			MYSQL_PASSWORD: wordpress
		volumes:
			- mysql-data:/var/lib/mysql
		networks: 
			- my_net

networks: 
	my_net:

volumes: 
	mysql-data: 
	wordpress-data:
```

Command
```shell
docker stack deploy -c <compose.yml> <stack-name>
docker stack ls
docker stack ps <stack-name>
docker service ls
docker stack rm <stack-name>
```

---

## Chapter 11: HAProxy LoadBalancer

Setup HAProxy on front VM
```shell
apt install haproxy –y
systemctl stop haproxy
vi /etc/haproxy/haproxy.cfg

frontend http_front
	bind *:80
	default_backend http_back
backend http_back
	balance roundrobin
	mode http
	server web1 192.168.0.111:80
	server web2 192.168.0.112:80
	server web3 192.168.0.113:80

systemctl start haproxy
systemctl enable haproxy
```

---
