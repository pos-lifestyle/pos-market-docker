NAME = poslifestyle/pos-market-docker
VERSION = 1.0.0

.PHONY: build

build:
	docker build -t poslifestyle/pos-market-apache apache
	docker build -t poslifestyle/pos-market-mysql mysql
	docker build -t poslifestyle/pos-market-php-cli php-cli
	docker build -t poslifestyle/pos-market-php-fpm php-fpm
