#!/bin/bash
#####################################
# NAME : V.THIPPAREDDY
# DATE: 01/05/024
# VERSION:1.00.0
# I am installing chefserver using the script chefserver.sh
# $# - Used to check for no of arguments $? - represents result count $(!!) - represents previous results command
# Example of variable is Name="ThippaReddy" && Arguments is Name="$1"
# Arrays are used to write multiple strings in the same variable synta is ARRAY = (name,thippa,reddy)
###############################################

WORKSTATION_VERSION=$1
UBUNTU_VERSION=$2

if [ $# -lt 2 ];
then
    echo "Number of arguments are passed incorrectly"
    exit1
fi
function wget_Download {
echo "Checking if wget is available or not to download the chef server package"
wget --version
if [ $? -eq 0 ];
then
    echo "Wget is available"
else
    echo "Downloading wget package"
    sudo apt-get install wget -y
            if [ $? -eq 0 ];
            then
                echo "Wget downloaded successfully"
            else
                echo "Unable to download wget"
                exit 1
            fi
fi
}
wget_Download

function ubuntu_chef {
    echo "Downloading chef server package for ubuntu server"
    sudo apt update
    wget https://packages.chef.io/files/stable/chef-workstation/$WORKSTATION_VERSION/ubuntu/$UBUNTU_VERSION/chef-workstation_$WORKSTATION_VERSION-1_amd64.deb
        if [ $? -eq 0 ];
        then
            echo "Chef server package downloaded successfully"
        else
            echo "Unabe to downlaod chef server package"
            exit 1
        fi
    echo "Installing chef server on ubuntu server"
    dpkg -i chef-workstation_$WORKSTATION_VERSION-1_amd64.deb
        if [ $? -eq 0 ];
        then
            echo "Unable to install chef server package"
            exit 1
        else
            echo "Chef server package installed successfully"
            chef -v
        fi
}

function redhat_chef{
    echo "Downloading chef server package for Redhat server"
    sudo apt update
    wget https://packages.chef.io/files/stable/chef-workstation/$WORKSTATION_VERSION/ubuntu/$UBUNTU_VERSION/chef-workstation_$WORKSTATION_VERSION-1_amd64.deb
        if [ $? -eq 0 ];
        then
            echo "Chef server package downloaded successfully"
        else
            echo "Unabe to downlaod chef server package"
            exit 1
        fi
    echo "Installing chef server on ubuntu server"
    dpkg -i chef-workstation_$WORKSTATION_VERSION-1_amd64.deb
        if [ $? -eq 0 ];
        then
            echo "Unable to install chef server package"
            exit 1
        else
            echo "Chef server package installed successfully"
            chef -v
        fi
}

if [ "$(grep -Ei 'debian|ubuntu|mint' /etc/*release)" ];
then
     echo "Calling ubuntu function"
     ubuntu_chef
elif [ "$(grep -Ei 'centos|redhat' /etc/*release)" ];
then
     echo "Calling Redhat chef package"
     redhat_chef
else
    echo "Unsupported OS"
    exit 1
fi
#Adding few lines of comments by user-1
##Adding second line of comments by user-1