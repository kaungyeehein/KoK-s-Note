# Postgres with Docker

## 1. Docker command
```
docker pull postgres:16
docker volume create postgres_data
docker run --name postgres_16 \
	-p 5432:5432 \
	-e POSTGRES_PASSWORD=postgres \
	-v postgres_data:/var/lib/postgresql/data \
	-d postgres:16
docker ps

docker pull dpage/pgadmin4:8.10
docker run --name pgadmin_4 \
	-p 80:80 \
    -e 'PGADMIN_DEFAULT_EMAIL=admin@domain.com' \
    -e 'PGADMIN_DEFAULT_PASSWORD=admin' \
    -d dpage/pgadmin4:8.10
docker ps

docker container inspect postgres_16	# Check postgres ip address

http://localhost
username: admin@domain.com
password: admin
```

## 2. Docker Compose

docker-compose.yml
```yml
name: test_db
services:
	postgres_16:
		image: postgres:16
		restart: always
		ports:
		  - '5432:5432'
		environment:
			POSTGRES_PASSWORD: 'postgres'
		volumes:
          - postgres_data:/var/lib/postgresql/data # Create in volume
          # - ./postgres_data:/var/lib/postgresql/data # Create in current directory
		networks: 
			- my-net
		healthcheck:
			test: ["CMD-SHELL", "pg_isready -d postgres -U postgres"]
			interval: 1s
			timeout: 5s
			retries: 10
	pgadmin_4:
		image: dpage/pgadmin4:8.10
    	restart: always
	    ports:
	      - '80:80'
		environment:
			PGADMIN_DEFAULT_EMAIL: 'admin@domain.com'
			PGADMIN_DEFAULT_PASSWORD: 'admin'
		networks: 
			- my-net
	    depends_on:
	     	postgres_16:
				condition: service_healthy

volumes:
	postgres_data:

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

## 3. Environment variables

We’ve touched briefly on the importance of `POSTGRES_PASSWORD` to Postgres. Without specifying this, Postgres can’t run effectively. But there are also other variables that influence container behavior: 

- `POSTGRES_USER` – Specifies a user with superuser privileges and a database with the same name. Postgres uses the default user when this is empty.
- `POSTGRES_DB` – Specifies a name for your database or defaults to the `POSTGRES_USER` value when left blank. 
- `POSTGRES_INITDB_ARGS` – Sends arguments to `postgres_initdb` and adds functionality
- `POSTGRES_INITDB_WALDIR` – Defines a specific directory for the Postgres transaction log. A transaction is an operation and usually describes a change to your database. 
- `POSTGRES_HOST_AUTH_METHOD` – Controls the `auth-method` for `host` connections to `all` databases, users, and addresses
- `PGDATA` – Defines another default location or subdirectory for database files

These variables live within your plain text `.env` file. Ultimately, they determine how Postgres creates and connects databases. You can check out our [GitHub Postgres Official Image documentation](https://github.com/docker-library/docs/blob/master/postgres/README.md) for more details on environment variables.

## 4. Docker secrets

```
docker run --name some-postgres -e POSTGRES_PASSWORD_FILE=/run/secrets/postgres-passwd -d postgres
```

## 5. Initialization scripts

Also called `init` scripts, these run any executable shell scripts or command-based `.sql` files once Postgres creates a `postgres-data` folder. This helps you perform any critical operations before your services are fully up and running. Conversely, Postgres will ignore these scripts if the `postgres-data` folder initializes.

## 6. Database configuration

There are two ways you can handle database configurations with Postgres. You can either apply these configurations locally within a dedicated file or use the command line. The CLI uses an entrypoint script to pass any Docker commands to the Postgres server daemon for processing. 

Reference:

- https://www.docker.com/blog/how-to-use-the-postgres-docker-official-image
- https://github.com/docker-library/docs/blob/master/postgres/README.md
- https://github.com/docker/awesome-compose/tree/master/postgresql-pgadmin


