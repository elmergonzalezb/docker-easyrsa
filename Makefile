#!/usr/bin/make -f

.PHONY: build clean

build:
	docker build -t tonymke/easy-rsa .

clean:
	docker rmi -f tonymke/easy-rsa
