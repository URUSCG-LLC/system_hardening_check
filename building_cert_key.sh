#!/bin/bash

ssl_dir='/etc/nginx/ssl'
mkdir ${ssl_dir}



create_certs(){

	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt
	}



if [[  -d ${ssl_dir} ]]; then
	#statements
	create_certs
else
	printf "\033[35mError:\033[0m \033[31mUnable to find directory ${ssl_dir}.\033[0m\n"
fi
