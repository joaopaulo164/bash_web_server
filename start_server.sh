#!/bin/bash
 
## Quit netstat CTRL+C
trap 'echo Saindo...; exit' SIGINT SIGQUIT
 
## Server Port
PORTA="8080"
 
## Server Script (HTTP)
PROGRAMA="server_config.sh"
 
## Start netcat
while true
do
  nc -l -p "$PORTA" -e "$PROGRAMA"
done
