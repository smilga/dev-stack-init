#!/bin/bash

###########################################################
###########################################################
# Bash script to set up php, js, go dev enviroment
###########################################################
###########################################################

# Define install modules
MODULE_PHP=("PHP dev enviroment (php, composer)" false)
MODULE_GO=("Go dev enviroment (go, tools)" false)
MODULE_STORAGE=("Storage module (redis, elasticsearch, mysql)" false)
MODULE_JS=("Javascript dev enviroment (node)" false)
MODULE_NGINX=("Nginx server" false)
INSTALL="Proceed selected modules"

# Draws screen with selected modules
draw() {
	clear
	echo "Choose install options:"
	echo "1 $(printC "${MODULE_PHP[@]}")"  
	echo "2 $(printC "${MODULE_GO[@]}")"  
	echo "3 $(printC "${MODULE_STORAGE[@]}")"  
	echo "4 $(printC "${MODULE_JS[@]}")"  
	echo -e "\n"
	echo "0 $INSTALL"
}

# Returns colored output 
printGreen() { echo -e "\e[32m$1\n\e[39m"; }
printGray() { echo -e "\e[90m$1\n\e[39m"; }
printYellow() { echo -e "\e[33m$1\n1\e[39m"; }

# Returns colored module name depending on value
function printC() {
	arr=("$@")
	if [ "${arr[1]}" == false ]; then
		echo $(printGray "${arr[0]}")
	else
		echo $(printGreen "${arr[0]}")
	fi
}

# Changes module state
function toggle() {
	if [ "$1" == false ]; then
		echo true
	else
		echo false
	fi
}

# Draws screen and waits for user input to change modules
while :
do
	draw
	# read key press
	read -n1 SEL

    case $SEL in
        1) MODULE_PHP[1]=$(toggle "${MODULE_PHP[1]}") ;;
        2) MODULE_GO[1]=$(toggle "${MODULE_GO[1]}") ;;
        3) MODULE_STORAGE[1]=$(toggle "${MODULE_STORAGE[1]}") ;;
        4) MODULE_JS[1]=$(toggle "${MODULE_JS[1]}") ;;
        0) echo -e "\n"; break  ;;
        *) echo "Invalid option" ;;
    esac
done

###########################################################

# Updating and dependencies

###########################################################
# echo $(printYellow "Updating apt list and upgrading system")
# sudo apt-get update -y
# sudo apt-get upgrade -y
# sudo apt-get install build-essential -y
###########################################################

# PHP module
 
###########################################################
if [ "${MODULE_PHP[1]}" == true ]; then
	echo $(printYellow "Processing PHP module")
	sudo add-apt-repository ppa:ondrej/php -y
	sudo apt-get install php7.1 php7.1-bcmath php7.1-bz2 php7.1-fpm php7.1-cli php7.1-curl php7.1-gd php7.1-imap php7.1-intl php7.1-json php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-xml php7.1-zip -y
	sudo apt-get install composer -y
	#TODO set compser paths 
fi
###########################################################

# Nginx module
 
###########################################################
if [ "${MODULE_NGINX[1]}" == true ]; then
	echo $(printYellow "Processing nginx module")
	sudo apt-get install nginx -y
	#TODO configure
fi
###########################################################

# Storage module
 
###########################################################
if [ "${MODULE_STORAGE[1]}" == true ]; then
	echo $(printYellow "Processing storage module")
	# elasticsaerch
	wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
	echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-6.x.list
	sudo apt-get update && sudo apt-get install elasticsearch -y
	# mysql
	sudo apt-get install mysql-server -y
	# redis
	sudo apt-get install redis-server -y
fi
###########################################################

# Javascript module
 
###########################################################
if [ "${MODULE_JS[1]}" == true ]; then
	echo $(printYellow "Processing javscript module")
	curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
	sudo apt-get install -y nodejs
	#TODO configure node modules to user 
fi


#TODO
# Install golang and add paths
# Add composer bin to path
# Change node modules no user space

# Configure redis and elastic not to start by default

# generate ssh key

# emacs
# silversearcher-ag
# zsh
# vlc
# slack-desktop
# openssh-server
# firefox
# chrome
# composer
# cmake
# unrar
