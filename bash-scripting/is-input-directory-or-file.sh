#!/bin/bash

if [[ -n $1 ]] && [[ -d $1 ]]; then
    echo "You have entered a dir path."
elif [[ -n $1 ]] && [[ -e $1 ]]; then
    echo "You have entered a file path."
elif [[ -z $1 ]]; then
    echo "You have not entered any input."
else
    echo "Input is neither a file nor a dir."
fi
