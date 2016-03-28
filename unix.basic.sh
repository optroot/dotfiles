# Check that we are root

if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root [sudo !!]" ; exit 1 ; fi

# TODO apt-get/yum etc.
apt-get update
apt-get install -y build-essential checkinstall
apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev
apt-get install -y curl

apt-get install -y screen tmux vim git
apt-get install -y rar unrar p7zip p7zip-full
apt-get install -y libncurses-dev

apt-get install -y exuberant-ctags astyle autopep8
apt-get install -y default-jre default-jdk
apt-get install -y cython
apt-get install -y octave
apt-get install -y pandoc

apt-get install -y bmon
apt-get install -y htop

apt-get install -y python-setuptools python-pip
pip install numpy
pip install sklearn

apt-get install -y openssh-server
apt-get install -y imagemagick

apt-get install -y apache2
apt-get install -y mysql-server libapache2-mod-auth-mysql php5-mysql
apt-get install -y php5 libapache2-mod-php5 php5-mcrypt

