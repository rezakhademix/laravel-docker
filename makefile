#!make

default: help

ps: ## docker compose ps
	docker compose ps

up: ## docker compose up
	docker compose up -d

down: ## docker compose down
	docker compose down

down-volumes: ## docker compose down with volumes
	docker compose down --volumes

restart: ## docker compose restart
	docker compose restart

composer-install: ## composer install
	docker compose run --rm composer i

npm-install: ## npm install
	docker compose run --rm npm i

tinker: ## artisan tinker
	docker compose run --rm artisan tinker

art: ## run artisan command
	docker compose run --rm artisan $(filter-out $@,$(MAKECMDGOALS))
%:
	@:	

migration: ## make a new migration
	docker compose run --rm artisan make:migration $(filter-out $@,$(MAKECMDGOALS))
%:
	@:	

# makefile help
help:
	@echo "usage: make [command]"
	@echo ""
	@echo "available commands:"
	@sed \
    		-e '/^[a-zA-Z0-9_\-]*:.*##/!d' \
    		-e 's/:.*##\s*/:/' \
    		-e 's/^\(.\+\):\(.*\)/$(shell tput setaf 6)\1$(shell tput sgr0):\2/' \
    		$(MAKEFILE_LIST) | column -c2 -t -s :
