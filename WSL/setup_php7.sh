apt-get -y update

#php7.1
apt-get -y install apt-transport-https lsb-release ca-certificates
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list
apt-get -y update
apt-get -y install php7.1
apt-get -y install php7.1-cli php7.1-common php7.1-curl php7.1-gd php7.1-json php7.1-mbstring php7.1-mysql php7.1-opcache php7.1-readline php7.1-xml

#Utils
apt-get -y install git yarn default-jre libpng* nodejs make gcc g++ libc-dev

#node & npm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.9/install.sh | bash
source ~/.bashrc
nvm install --lts

# SSH
mkdir ~/.ssh
chmod 600 ~/.ssh

cat - <<EOF >> ~/.bashrc
alias sks="rm ~/.ssh/* ; find /mnt/c/Users/Thomas/.ssh/ -type f -exec cp {} ~/.ssh \; ;chmod 600 ~/.ssh/*\;"
EOF
. ./.bashrc && sks

# BFG
wget -O bfg.jar http://repo1.maven.org/maven2/com/madgag/bfg/1.13.0/bfg-1.13.0.jar
cat - <<EOF >> ~/.bashrc
alias bfg="java -jar ~/bfg.jar"
EOF