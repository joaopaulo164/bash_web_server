#!/bin/bash

## Read URL
read URL

## Read utill find empty line
while read HEADER
do
	## Concatenate line in fullheader
	FULLHEADER="$FULLHEADER\n\t$HEADER"

	## Leave on empty line
	[ -z "$(echo $HEADER | tr -d '\r\n')" ] && break
done

## LOG
echo -e "-------------------------------" >&2
echo -e "$(date) ---- HTTP ---- Received $URL" >&2
echo -e "$(date) ---- HTTP ---- Header:" >&2
echo -e "Header: $FULLHEADER" >&2

## Request validation
TARGET=$(echo $URL | cut -d ' ' -f 2)

case $TARGET in
/)
  FILE="index.html";
  STATUS_NUMBER="200";
  STATUS_NAME="OK"
;;
/home)
  FILE="home.html";
  STATUS_NUMBER="200";
  STATUS_NAME="OK"
;;
/blah)
  FILE="blah.html"
  STATUS_NUMBER="200";
  STATUS_NAME="OK"
;;
*)
  FILE="error.html"
  STATUS_NUMBER="404";
  STATUS_NAME="NotFound"
;;
esac

## Reply
cat << EOF
HTTP/1.1 $STATUS_NUMBER - $STATUS_NAME
Date: $(date)
Server: ShellHTTP
Content-Length: $(wc --bytes $FILE | cut -d ' ' -f 1)
Connection: close
Content-Type: text/html; charset=utf-8

$(cat $FILE)
EOF
