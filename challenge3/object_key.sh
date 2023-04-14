#!/bin/bash
declare -A obj
obj[name]='laxmi'
obj[age]=28
obj[city]='guagon'

key=$1
value=${obj[$key]}

echo $value