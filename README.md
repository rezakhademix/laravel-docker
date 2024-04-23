# Dockerize Laravel App


NOTE: [If you want to Dockerize Laravel, Postgres, Nginx, PGAdmin, Adminer, Mailhog, Npm and Redis. Please use this repo:](https://github.com/rezakhademix/laravel-postgres-docker)



A simplified Docker Compose workflow that sets up relevant containers for Laravel development. (Laravel, Mysql, Nginx, PhpMyAdmin, Npm and Redis)

## Usage

To get started, make sure you have [Docker installed](https://docs.docker.com/docker-for-mac/install/) on your system, and then clone this repo.

Next, navigate in your terminal to the directory you cloned this repositoruy and run `docker compose up -d --build`.

After that, follow the steps from the [src/README.md](src/README.md) file to get your Laravel project up & running or create a new Laravel app.

**Note**: Your MySQL database host name should be `mysql`, **note** `localhost`. The username and database should both be `homestead` with a password of `secret`.

The containers and their exposed ports are:

-   **nginx** - `:80`
-   **mysql** - `:3306`
-   **php** - `:9000`
-   **redis** - `:6379`
-   **phpmyadmin** - `:8081`

Use the following command examples from your root directory to run Composer, NPM or Artisan commands:

-   `docker compose run --rm composer install`
-   `docker compose run --rm npm run dev`
-   `docker compose run --rm artisan migrate`

## Makefile

There is a `makefile` which can help you to run every docker or artisan command easily. If you're not familiar with [GNU Makefile](https://www.gnu.org/software/make/manual/make.html) it's ok and you can still use this repository (even you can delete `makefile`), but with `makefile` you can manage different commands easier and better! Before using a `makefile` just install it from [GNU Makefile](https://www.gnu.org/software/make/manual/make.html) and run `make` command in repository root directory and you will see a help result to use it. Some of make command example to simplify workflow:

```
# run docker compose up -d
make up

# run docker compose down --volumes
make down-volumes

# run migrations
make migrate

# run tinker
make tinker

# run artisan commands
make art db:seed
```

## Persistent MySQL Storage

By default, whenever you bring down the Docker network, your MySQL data will be removed after the containers are destroyed. If you would like to have persistent data that remains after bringing containers down and back up, do the following:

1. Create a `mysql` folder in the project root, alongside the `nginx` and `src` folders.
2. Under the mysql service in your `docker-compose.yml` file, add the following lines:

```
volumes:
  - ./mysql:/var/lib/mysql
``` 

1. If you want to initialize database data with a sql file you should create a `docker-entrypoint-initdb.d` folder inside `./mysql` and put your `db.sql` file into it.

#### another way of doing the 2,3:

```
volumes:
  mysql:
    driver: local
```

If you would like to have persistent redis data that remains after bringing containers down and back up:
```
volumes:
  - redis:/data
```

volumes:
  mysql:
    driver: local
  redis:
    driver: local
``` 

## Docker exec container

Access container as interactive shell and see output:

```
docker exec -it <container id> sh
```

Tip: You may use /bin/bash or just bash so after installing bash, you should inspect your image to understand CMD part and change current
option to whatever you want. For this purpose run:

```
docker inspect [imageID]
```

## Usage in Production

Tip 1: Don't forget to configure opcache
Tip 2: Don't forget about SSL

## Compiling Assets

It is better to compile assets in production mode. You need to add ` --host 0.0.0.0` after the end of your dev command in `package.json`. For example, with a Laravel project using Vite, you should have:

```json
"scripts": {
  "dev": "vite --host 0.0.0.0",
  "build": "vite build"
},
```

Then, run the following commands to install your dependencies and start the dev server:

-   `docker compose run --rm npm install`
-   `docker compose run --rm --service-ports npm run dev`

If you want to build for production? simply run `docker compose run --rm npm run build`.
