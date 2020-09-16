#! /bin/bash

# Detect platform-dependent options
OS=`uname -a | cut -d ' ' -f 1`
echo "OS: $OS"

if [ "$OS" == 'Darwin' ]; then
    PLATFORM=osx
    SCRIPTDIR=$(cd "$(dirname "$0")"; pwd)

    if [ -x /usr/local/bin/brew ]; then
        PACKAGE_MANAGER=brew
    else
        echo 'No package manager found. Install brew to continue.' && exit 1
    fi
elif [ "$OS" == 'Linux' ]; then
    PLATFORM=linux
    SCRIPT=$(readlink -f $0)
    SCRIPTDIR=$(dirname $SCRIPT)

    if [ -x /usr/bin/apt ]; then
        PACKAGE_MANAGER=apt
    elif [ -x /usr/bin/yum ]; then
        PACKAGE_MANAGER=yum
    elif [ -x /sbin/apk ]; then
        PACKAGE_MANAGER=apk
    else
        echo 'No package manager found. Install aptitude, yum or apk to continue.' && exit 1
    fi
else
    echo "Unrecognized OS: $OS" && exit 1
fi

echo "Platform: $PLATFORM"
echo "Package manager: $PACKAGE_MANAGER"

# Install necessary packages
function install_brew_packages() {
    echo 'Installing brew packages...'

    # Install dependencies
    brew install krb5
}

function install_apt_packages() {
    echo 'Installing apt packages...'

    # Update
    apt update

    # Install dependencies
    DEBIAN_FRONTEND='noninteractive' apt -y install krb5-user libkrb5-dev
}

function install_yum_packages() {
    echo 'Installing yum packages...'

    # Update
    yum check-update

    # Install dependencies
    yum -y install krb5-workstation krb5-devel
}

function install_apk_packages() {
    echo 'Installing apk packages...'

    # Update
    apk update

    # Install dependencies
    apk add krb5 krb5-dev
}

eval "type install_${PACKAGE_MANAGER}_packages &>/dev/null && install_${PACKAGE_MANAGER}_packages"

# 3. Create krb5 conf based on environment variables
# 4. Init Kerberos based on selected auth method (Password/PAM/Keytab)
