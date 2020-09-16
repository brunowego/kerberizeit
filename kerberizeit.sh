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

# 2. Install Dependencies based on OS release (/etc/os-release)
# 3. Create krb5 conf based on environment variables
# 4. Init Kerberos based on selected auth method (Password/PAM/Keytab)
