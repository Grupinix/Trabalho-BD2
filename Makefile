#!/bin/bash
.PHONY: default
.SILENT:


default:

start:
	docker-compose up -d

configure:
	bash ./configure.sh

stop:
	docker-compose down

remove:
	docker-compose down -v

ps:
	docker-compose ps
