#!/bin/bash

NAME=""
EMAIL=""

read -p "Enter your Git user name: " NAME
read -p "Enter your Git user email: " EMAIL

COMMAND="[user]\n    name = " + "$NAME" + "\n    email = " + "$EMAIL" + "\n[credential]\n    helper = store"
echo -e $COMMAND >> ~/.gitconfig

