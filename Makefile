all: latest apache

latest:
	docker build -t="coderstephen/php7:latest" apache

apache:
	docker build -t="coderstephen/php7:apache" apache
