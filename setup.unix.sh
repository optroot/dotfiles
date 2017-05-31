#!/bin/sh

# TODO case/case for OS and whether we are root
# Add ~/bin/ 


# TODO remove
# This is a ROUGH command instruction to install vim/tmux from source
# do not run or source this file

# >&2 echo 'Do not directly run this file, use it a a rough guideline.'
# return 1 2> /dev/null || exit 1

# TODO install sshd and key

if [ $(id -u) -ne 0 ]; then 
    >&2 echo 'Please run as root'
    return 1 2> /dev/null || exit 1
fi

if command -v yum >/dev/null 2>&1; then
    INSTALLER='yum -y'
elif command -v apt-get >/dev/null 2>&1; then
    INSTALLER='apt-get -y'
else
    >&2 echo 'Unknown Installer'
    return 1 2> /dev/null || exit 1
fi

# TODO install
# pandoc/latex 
# ssh config for sshkey login

# TODO include sshd_config and others

# /etc/ssh/sshd_config
# Port 22
# Protocol 2
# HostKey /etc/ssh/ssh_host_rsa_key
# HostKey /etc/ssh/ssh_host_dsa_key
# HostKey /etc/ssh/ssh_host_ecdsa_key
# HostKey /etc/ssh/ssh_host_ed25519_key
# UsePrivilegeSeparation yes
# KeyRegenerationInterval 3600
# ServerKeyBits 1024
# SyslogFacility AUTH
# LogLevel INFO
# LoginGraceTime 120
# #PermitRootLogin without-password
# PermitRootLogin yes
# StrictModes yes
# RSAAuthentication yes
# PubkeyAuthentication yes
# #AuthorizedKeysFile	%h/.ssh/authorized_keys
# IgnoreRhosts yes
# RhostsRSAAuthentication no
# HostbasedAuthentication no
# PermitEmptyPasswords no
# ChallengeResponseAuthentication no
# X11Forwarding yes
# X11DisplayOffset 10
# PrintMotd no
# PrintLastLog yes
# TCPKeepAlive yes
# AcceptEnv LANG LC_*
# Subsystem sftp /usr/lib/openssh/sftp-server
# UsePAM yes

SSHKEY="ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAhhrCQumubxL3af1c+jB5dE+6+tsfwfgni015N6yeG1A3ANDvwBAFa5X6trB6qDoXIkuixty+Vg5ZaODVqO7DRJ/+HnOxdY/42/u35k/yiwBPHQ9OyOmG0OV4pNQPqZTCHA0cnUbkF7uN1rChnCUbqXP3Qw3n6oT13PJKetJTLVVY50wQnJ+Z+kub5/2rAB/KrYCRJeQFblNCy6/ZwnAiNw3iRZkyk7DTwFLilu848/cfOja24l42L7Y46a9hEm1S0QxQhopu/ef+Ub6SW8XS0vSxNnGyPA51tG9JqewF0GzqQvKDBJXFQ/sQnp15Rx9Q7/UOkaWiK0+yQurxD5TkjQ== rsa-key-20150615"

"~/.ssh/authorized_keys2" 

if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
    chmod 700 ~/.ssh
fi

if [ ! -f ~/.ssh/authorized_keys2 ]; then 
    touch ~/.ssh/authorized_keys2 
    chmod 644 ~/.ssh/authorized_keys2 
fi

if cat "~/.ssh/authorized_keys2" | grep "$SSHKEY" > /dev/null 2>&1; then 
    echo "ssh_key exists" 
else 
    echo "$SSHKEY" > ~/.ssh/authorized_keys2 
fi

# TODO ask/confirm before each

$INSTALLER update

$INSTALLER install build-essential libreadline-gplv2-dev libssl-dev libsqlite3-dev libgdbm-dev libc6-dev libbz2-dev ncurses-dev libncurses-dev libncursesw5-dev imagemagick 
$INSTALLER install checkinstall curl git
$INSTALLER install php5 python27 perl
$INSTALLER install php5-mcrypt php5-mysql python-setuptools python-pip 
$INSTALLER install apache2 mysql-server libapache2-mod-auth-mysql libapache2-mod-php5 

# # echo $INSTALLER install ffmpeg libav-tools 
# $INSTALLER install php5 ruby ruby-full python27 lua5.2 perl
# $INSTALLER install liblua5.1-dev luajit libluajit-5.1
# $INSTALLER install cython octave default-jre default-jdk
# $INSTALLER install php5-mcrypt php5-mysql python-setuptools python-pip 
# $INSTALLER install apache2 mysql-server libapache2-mod-auth-mysql libapache2-mod-php5 
# $INSTALLER install exuberant-ctags astyle autopep8 


# Libraries
# $INSTALLER install build-essential libreadline-gplv2-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev ncurses-dev libncurses-dev libncursesw5-dev imagemagick 
#
# # Basic Tools
# $INSTALLER install checkinstall curl git rar unrar p7zip p7zip-full
#
# # Monitoring Tools
# $INSTALLER install bmon htop
#
# # Extra Tools
# # echo $INSTALLER install ffmpeg libav-tools 
#
# # Languages
# $INSTALLER install php5 ruby ruby-full python27 lua5.2 perl
#
# # Lua
# $INSTALLER install liblua5.1-dev luajit libluajit-5.1
#
# # More Languages
# $INSTALLER install cython octave default-jre default-jdk
#
# # Language Extensions
# $INSTALLER install php5-mcrypt php5-mysql python-setuptools python-pip 
#
# # Webstack
# $INSTALLER install apache2 mysql-server libapache2-mod-auth-mysql libapache2-mod-php5 
#
# # Language Tools
# $INSTALLER install exuberant-ctags astyle autopep8 
#
# pip install numpy sklearn
#
# mkdir -p install
# cd install
#
# # luajit
#
# # wget http://luajit.org/download/LuaJIT-2.0.4.tar.gz
# # tar -zxvf LuaJIT-2.0.4.tar.gz
# # rm LuaJIT-2.0.4.tar.gz
# # cd LuaJIT-2.0.4
# # make && make install
# # cd ../
#
#
# # VIM
#
# # TODO check?
#
# # VIM
#
# if vim --version | grep '+python' >/dev/null 2>&1 &&
#    vim --version | grep '+lua' >/dev/null 2>&1&&
#    vim --version | grep '+clipboard' >/dev/null 2>&1&&
#    vim --version | grep '+timers' >/dev/null 2>&1&&
#    vim --version | grep 'Vi IMproved 8.0' >/dev/null 2>&1; then
#     echo 'vim already installed'
# else 
#     # sudo $INSTALLER purge vim vim-runtime vim-grome vim-gtk vim-tiny vim-common vim-gui-common
#     # TODO update alternatives?
#
#     [ -e "master.zip" ] || wget https://github.com/vim/vim/archive/master.zip 
#     [ -e "vim-master" ] || unzip master.zip
#     cd vim-master/src
#     ./configure \
#         --with-features=huge \
#         --enable-gui=auto \
#         --enable-gtk-check \
#         --enable-gnome-check \
#         --enable-rubyinterp=yes \
#         --enable-pythoninterp=yes \
#         --enable-perlinterp=yes \
#         --enable-luainterp=yes \
#         --with-lua-prefix=/usr/include/lua5.1 \
#         --with-luajit --enable-fail-if-missing && make && make install
#     cd ../../
# fi
#
# # TMUX
# if tmux -V | grep 'tmux 2.3' >/dev/null 2>&1; then
#     echo 'tmux already installed'
# else
#     [ -e "libevent-2.0.22-stable.tar.gz" ] || wget https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz
#     [ -e "libevent-2.0.22-stable" ] || tar -zxvf libevent-2.0.22-stable.tar.gz
#     cd libevent-2.0.22-stable
#     ./configure && make && make install
#     cd ../
#
#     [ -e "tmux-2.3.tar.gz" ] || wget https://github.com/tmux/tmux/releases/download/2.3/tmux-2.3.tar.gz
#     [ -e "tmux-2.3" ] || tar -zxvf tmux-2.3.tar.gz
#     cd tmux-2.3
#     ./configure && make && make install
#     cd ../
# fi
#
# cd ../
# # echo rm -rf install
#
# # check and run xterm-256-color.italic

