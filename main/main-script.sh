#!/bin/bash

echo "##########################################"
echo "##### MAIN SCRIPT - has been started #####"
echo "##########################################"

echo "Moving to temporary directory"
cd /tmp || exit

echo "removing old time-lapsed log files"
rm -f init-time-process-log.txt
rm -f end-time-process-log.txt

echo "Creating init file time log"
touch init-time-process-log.txt

echo "###################################################"
echo "### Operation System Scripts - has been started ###"
echo "###################################################"

echo "--------------------------------------------------------"
echo "LOG - Installing SNAP ..."
sudo rm /etc/apt/preferences.d/nosnap.pref
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock
sudo apt update
sudo apt -y install snapd

echo "--------------------------------------------------------"
echo "LOG - Installing UNZIP ..."
sudo apt update
sudo apt -y install unzip

echo "--------------------------------------------------------"
echo "LOG - Turning completion case insensitive ..."
if [ ! -a ~/.inputrc ];then 
    echo '$include /etc/inputrc' > ~/.inputrc;
fi
echo 'set completion-ignore-case On' >> ~/.inputrc

echo "###################################################"
echo "   Operation System Scripts -  HAS BEEN FINISHED   "
echo "###################################################"


echo "##############################################"
echo "### GIT - install process has been started ###"
echo "##############################################"

sudo apt update
sudo apt -y install git

echo "GIT install process finished"

echo "######################################################"
echo "### DEFAULT JRE - install process has been started ###"
echo "######################################################"

sudo apt -y install default-jre

echo "DEFAULT JRE install process finished"

echo "#############################################################"
echo "### VISUAL STUDIO CODE - install process has been started ###"
echo "#############################################################"

sudo apt update
sudo apt -y install software-properties-common apt-transport-https wget
wget https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt update
sudo apt -y install code

echo "VSCode install process finished"

echo "####################################################################"
echo "### DOCKER and DOCKER_COMPOSE - install process has been started ###"
echo "####################################################################"

sudo apt-get -y remove docker docker-engine docker.io docker-compose containerd runc
sudo apt-get update
sudo apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(. /etc/os-release; echo "$UBUNTU_CODENAME") stable"
sudo apt-get update
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-compose
sudo usermod -aG docker $USER
docker --version
docker-compose --version

echo "LOG - Docker and Docker compose install process finished"

echo "###################################################"
echo "### OPEN VPN - install process has been started ###"
echo "###################################################"

sudo apt -y install network-manager-openvpn-gnome

echo "OPEN VPN - install process finished"


echo "#########################################################"
echo "### AWS VPN CLIENT - install process has been started ###"
echo "#########################################################"

echo "LOG - adding apt-key"
wget -q -O - https://d20adtppz83p9s.cloudfront.net/GTK/latest/debian-repo/awsvpnclient_public_key.asc | sudo apt-key add -

echo "LOG - adding to repo to /etc/apt/sources.list.d/aws-vpn-client.list"
echo "deb [arch=amd64] https://d20adtppz83p9s.cloudfront.net/GTK/latest/debian-repo ubuntu-20.04 main" | sudo tee /etc/apt/sources.list.d/aws-vpn-client.list

echo "updating apt-get"
sudo apt-get update

echo "LOG - installing client"
sudo apt-get install awsvpnclient

echo "#########################################################"
echo "#### LOG - AWS VPN CLIENT - install process finished ####"
echo "#########################################################"
echo "#####################################################"
echo "### TERMINATOR - install process has been started ###"
echo "#####################################################"

sudo apt update
sudo apt -y install terminator

echo "terminator install process finished"

echo "#######################################################"
echo "### APACHE MAVEN - install process has been started ###"
echo "#######################################################"

echo "LOG - Downloading Apache Maven 3.6.3 ..."
wget https://dlcdn.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
tar -xzf apache-maven-3.6.3-bin.tar.gz
rm apache-maven-3.6.3-bin.tar.gz

echo "installing Apache Maven into /opt/apache-maven-3.6.3 ..."
if [ -d "/opt/apache-maven-3.6.3" ];then
	sudo rm -rf /opt/apache-maven-3.6.3
fi
sudo mv apache-maven-3.6.3 /opt/apache-maven-3.6.3

echo "LOG - Setting up MAVEN_HOME, M2_HOME and M2 environments for: Maven ..."
echo " " >> ~/.bashrc
echo "# MAVEN environment config" >> ~/.bashrc
echo "M2_HOME=/opt/apache-maven-3.6.3" >> ~/.bashrc
echo "export M2_HOME" >> ~/.bashrc
echo "M2=\$M2_HOME/bin" >> ~/.bashrc
echo "export M2" >> ~/.bashrc
echo "PATH=\$PATH:\$M2" >> ~/.bashrc

echo "LOG - Apache Maven install process finished"

echo "###################################################"
echo "### PY CHARM - install process has been started ###"
echo "###################################################"

echo "LOG - Downloading PyCharm 2022.1 community ..."
wget https://download.jetbrains.com/python/pycharm-community-2022.1.tar.gz
tar -xzf pycharm-community-2022.1.tar.gz
rm pycharm-community-2022.1.tar.gz

echo "LOG - installing pycharm into /opt/pycharm ..."
if [ -d "/opt/pycharm" ];then
	sudo rm -rf /opt/pycharm
fi
sudo mv pycharm-community-2022.1 /opt/pycharm

echo "LOG - Increasing the memory heap of the IDE on vmoptions Xms1024 and Xmx2048 ..."
sudo sed -i 's/Xms128m/Xms1024m/' /opt/pycharm/bin/pycharm64.vmoptions
sudo sed -i 's/Xmx750m/Xmx2048m/' /opt/pycharm/bin/pycharm64.vmoptions

echo "LOG - Creating symbolic link..."
if [ -L "/usr/bin/pycharm" ];then
    sudo rm -f /usr/bin/pycharm
fi
sudo ln -s /opt/pycharm/bin/pycharm.sh /usr/bin/pycharm
sudo chmod +x /usr/bin/pycharm

echo "LOG - Creating desktop entry for pycharm"
if [ -L "/tmp/pycharm.desktop" ];then
    sudo rm -f /tmp/pycharm.desktop
fi
echo "[Desktop Entry]" >> pycharm.desktop
echo "Encoding=UTF-8" >> pycharm.desktop
echo "Name=pycharm IDEA" >> pycharm.desktop
echo "Exec=/opt/pycharm/bin/pycharm.sh" >> pycharm.desktop
echo "Icon=/opt/pycharm/bin/pycharm.png" >> pycharm.desktop
echo "Terminal=false" >> pycharm.desktop
echo "Type=Application" >> pycharm.desktop
echo "Categories=Development;" >> pycharm.desktop
echo "StartupNotify=true" >> pycharm.desktop
sudo mv pycharm.desktop ~/.local/share/applications

echo "LOG - pycharm install process finished"
echo "##################################################"
echo "### NODE_JS - install process has been started ###"
echo "##################################################"

echo "LOG - Downloading NodeJS 14.17.0 ..."
wget https://nodejs.org/dist/v14.17.0/node-v14.17.0-linux-x64.tar.gz
tar -xzf node-v14.17.0-linux-x64.tar.gz
rm node-v14.17.0-linux-x64.tar.gz

echo "LOG - installing - NodeJS 14.17 - into /opt/node-14.17.0 ..."
if [ -d "/opt/node-14.17.0" ];then
	sudo rm -rf /opt/node-14.17.0
fi
sudo mv node-v14.17.0-linux-x64 /opt/node-14.17.0

echo "LOG - Setting up NODE_JS environment for: NodeJS 14.17 ..."
echo " " >> ~/.bashrc
echo "# NodeJS environment config" >> ~/.bashrc
echo "NODE_JS=/opt/node-14.17.0" >> ~/.bashrc
echo "export NODE_JS" >> ~/.bashrc
echo "PATH=\$PATH:\$NODE_JS/bin" >> ~/.bashrc

echo "LOG - NodeJS install process finished"

echo "########################################################"
echo "### INTELLIJ IDEA - install process has been started ###"
echo "########################################################"

echo "LOG - Downloading intellij 2021.3 community ..."
wget https://download-cdn.jetbrains.com/idea/ideaIC-2021.3.tar.gz
tar -xzf ideaIC-2021.3.tar.gz
rm ideaIC-2021.3.tar.gz

echo "LOG - installing intellij into /opt/intellij ..."
if [ -d "/opt/intellij" ];then
	sudo rm -rf /opt/intellij
fi
sudo mv idea-IC-213.5744.223 /opt/intellij

echo "LOG - Increasing the memory heap of the IDE on vmoptions Xms1024 and Xmx2048 ..."
sudo sed -i 's/Xms128m/Xms1024m/' /opt/intellij/bin/idea64.vmoptions
sudo sed -i 's/Xmx750m/Xmx2048m/' /opt/intellij/bin/idea64.vmoptions

echo "LOG - Creating symbolic link..."
if [ -L "/usr/bin/intellij" ];then
    sudo rm -f /usr/bin/idea
fi
sudo ln -s /opt/intellij/bin/idea.sh /usr/bin/idea
sudo chmod +x /usr/bin/idea

echo "LOG - Creating desktop entry for intellij"
if [ -L "/tmp/intellij.desktop" ];then
    sudo rm -f /tmp/intellij.desktop
fi
echo "[Desktop Entry]" >> intellij.desktop
echo "Encoding=UTF-8" >> intellij.desktop
echo "Name=Intellij IDEA" >> intellij.desktop
echo "Exec=/opt/intellij/bin/idea.sh" >> intellij.desktop
echo "Icon=/opt/intellij/bin/idea.png" >> intellij.desktop
echo "Terminal=false" >> intellij.desktop
echo "Type=Application" >> intellij.desktop
echo "Categories=Development;" >> intellij.desktop
echo "StartupNotify=true" >> intellij.desktop
sudo mv intellij.desktop ~/.local/share/applications

echo "LOG - Intellij install process finished"

echo "##################################################"
echo "### POSTMAN - install process has been started ###"
echo "##################################################"

echo "LOG - Downloading Postman lastest ..."
wget https://dl.pstmn.io/download/latest/linux64
tar -xzf linux64
rm linux64

echo "LOG - Postman lastest into /opt/postman ..."
if [ -d "/opt/postman" ];then
	sudo rm -rf /opt/postman
fi
sudo mv Postman /opt/postman

echo "LOG - Creating symbolic link..."
if [ -L "/usr/bin/postman" ];then
    sudo rm -f /usr/bin/postman
fi
sudo ln -s /opt/postman/app/Postman /usr/bin/postman
sudo chmod +x /usr/bin/postman

echo "LOG - Creating desktop entry for Postman"
if [ -L "/tmp/postman.desktop" ];then
    sudo rm -f /tmp/postman.desktop
fi
echo "[Desktop Entry]" >> postman.desktop
echo "Encoding=UTF-8" >> postman.desktop
echo "Name=Postman" >> postman.desktop
echo "Exec=/opt/postman/app/Postman %U" >> postman.desktop
echo "Icon=/opt/postman/app/icons/icon_128x128.png" >> postman.desktop
echo "Terminal=false" >> postman.desktop
echo "Type=Application" >> postman.desktop
echo "Categories=Development;" >> postman.desktop
echo "StartupNotify=true" >> postman.desktop
sudo mv postman.desktop ~/.local/share/applications

echo "LOG - Postman install process finished"

echo "#######################################################"
echo "### ORACLE_JDK 8 - install process has been started ###"
echo "#######################################################"

echo "LOG - Downloading Oracle JDK 8 ..."
wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz
tar -xzf jdk-8u131-linux-x64.tar.gz
rm jdk-8u131-linux-x64.tar.gz

echo "LOG - Installing - Oracle JDK 8 - into /opt/oracle-jdk1.8.0_131 ..."
if [ -d "/opt/oracle-jdk1.8.0_131" ];then
	sudo rm -rf /opt/oracle-jdk1.8.0_131
fi
sudo mv jdk1.8.0_131 /opt/oracle-jdk1.8.0_131

#echo "the following instructions were commented cause OpenJDK 11 will be the default JDK"
#echo "Setting up JAVA_HOME environment for: Oracle JDK 8 ..."
#echo " " >> ~/.bashrc
#echo "# JDK environment config" >> ~/.bashrc
#echo "JAVA_HOME=/opt/oracle-jdk1.8.0_131" >> ~/.bashrc
#echo "export JAVA_HOME" >> ~/.bashrc
#echo "PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc

echo "LOG - Oracle JDK 8 install process finished"

echo "######################################################"
echo "### OPEN_JDK 11 - install process has been started ###"
echo "######################################################"

echo "LOG - Downloading OpenJDK 11 ..."
echo "LOG - Once and a while this step takes a long time."
wget https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz
tar -xzf openjdk-11.0.1_linux-x64_bin.tar.gz
rm openjdk-11.0.1_linux-x64_bin.tar.gz

echo "LOG - Installing - OpenJDK 11 - into /opt/jdk-11.0.1 ..."
if [ -d "/opt/jdk-11.0.1" ];then
	sudo rm -rf /opt/jdk-11.0.1
fi
sudo mv jdk-11.0.1 /opt/jdk-11.0.1

echo "LOG - Setting up JAVA_HOME environment for: OpenJDK 11 ..."
echo " " >> ~/.bashrc
echo "# JDK environment config" >> ~/.bashrc
echo "JAVA_HOME=/opt/jdk-11.0.1" >> ~/.bashrc
echo "export JAVA_HOME" >> ~/.bashrc
echo "PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc

echo "LOG - OpenJDK 11 - install process finished"

echo "#################################################"
echo "### GRADLE - install process has been started ###"
echo "#################################################"

VERSION=7.3.1

echo "LOG - Downloading Gradle ${VERSION} community ..."
wget https://services.gradle.org/distributions/gradle-${VERSION}-bin.zip
sudo unzip -d . gradle-${VERSION}-bin.zip
sudo rm -f gradle-${VERSION}-bin.zip

echo "LOG - installing gradle into /opt/gradle-${VERSION} ..."
if [ -d "/opt/gradle-${VERSION}" ];then
	sudo rm -rf /opt/gradle-${VERSION}
fi
sudo mv gradle-${VERSION} /opt/gradle-${VERSION}

echo "LOG - Setting up GRADLE_HOME environments for: Gradle ..."
echo " " >> ~/.bashrc
echo "# GRADLE environment config" >> ~/.bashrc
echo "GRADLE_HOME=/opt/gradle-${VERSION}" >> ~/.bashrc
echo "export GRADLE_HOME" >> ~/.bashrc
echo "PATH=\$PATH:\$GRADLE_HOME/bin" >> ~/.bashrc

echo "LOG - Gradle install process finished"

echo "#####################################################"
echo "### Kubernetes - install process has been started ###"
echo "#####################################################"

echo "### Installing Minikube ###"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
echo "### Minikube has been installed ###"

echo "### Installing Kind ###"
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.14.0/kind-$(uname)-amd64"
sudo chmod +x ./kind
sudo mkdir /opt/cluster_kind
sudo mv ./kind /opt/cluster_kind/kind
echo "LOG - Add Kind to path ..."
echo " " >> ~/.bashrc
echo "# Kubernetes Kind config" >> ~/.bashrc
echo "KUBE_KIND=/opt/cluster_kind" >> ~/.bashrc
echo "export KUBE_KIND" >> ~/.bashrc
echo "PATH=\$PATH:\$KUBE_KIND" >> ~/.bashrc
echo "### kind has been installed ###"


echo "### Installing kubectl ###"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
echo "### kubectl has been installed ###"
echo "##################################################"
echo "### SPOTIFY - install process has been started ###"
echo "##################################################"

sudo snap install spotify

echo "spotify install process finished"

echo "##################################################"
echo "### SUBLIME - install process has been started ###"
echo "##################################################"

sudo snap install sublime-text --classic

echo "Sublime install process finished"

echo "##################################################"
echo "### DISCORD - install process has been started ###"
echo "##################################################"

sudo snap install discord

echo "discord install process finished"

echo "################################################"
echo "### SLACK - install process has been started ###"
echo "################################################"

sudo snap install slack --classic

echo "slack install process finished"

echo "##################################################"
echo "### ROBO_3T - install process has been started ###"
echo "##################################################"

sudo snap install robo3t-snap

echo "Robo3t install process finished"

echo "###########################################################"
echo "### MY_SQL WORKBENCH - install process has been started ###"
echo "###########################################################"

sudo snap install mysql-workbench-community

echo "MySQL workbench install process finished"

echo "################################################"
echo "### OPERA - install process has been started ###"
echo "################################################"

sudo snap install opera

echo "opera install process finished"
echo "################################################"
echo "### SKYPE - install process has been started ###"
echo "################################################"

sudo snap install skype --classic

echo "skype install process finished"

echo "######################################################"
echo "### ECLIPSE IDE - install process has been started ###"
echo "######################################################"

sudo snap install eclipse --classic

echo "Eclipse install process finished"

echo "#####################################################"
echo "### HEROKU CLI - install process has been started ###"
echo "#####################################################"

sudo snap install heroku --classic

echo "HEROKU CLI install process finished"

echo "##################################################"
echo "### DBEAVER - install process has been started ###"
echo "##################################################"

echo "LOG - Downloading dbeaver-ce ..."

wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb
sudo rm -f dbeaver-ce_latest_amd64.deb

echo "LOG - dbeaver-ce install process finished"

echo "########################################################"
echo "### GOOGLE CHROME - install process has been started ###"
echo "########################################################"

echo "LOG - Downloading Chrome ..."

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo rm -f google-chrome-stable_current_amd64.deb

echo "LOG - Chrome install process finished"

echo "##########################################################################"
echo "##### Edney development environment initial setup - has been started #####"
echo "##########################################################################"

echo "--------------------------------------------------------------------------"
echo "LOG - Setting up git global config ..."
git config --global user.name "edneyRoldao"
git config --global user.email "edneyroldao@gmail.com"

echo "--------------------------------------------------------------------------"
echo "LOG - creating folders..."
mkdir ~/workspace
mkdir ~/workspace/docker
mkdir ~/workspace/shell-Scripts
mkdir ~/workspace/iterative
mkdir ~/workspace/iterative/files
mkdir ~/workspace/abasteceai
mkdir ~/workspace/abasteceai/files
mkdir ~/workspace/abasteceai/database
mkdir ~/workspace/abasteceai/database/local
mkdir ~/workspace/abasteceai/database/local/dumps
mkdir ~/workspace/commons-files
mkdir ~/workspace/java-projects
mkdir ~/workspace/node-projects
mkdir ~/workspace/other-projects
mkdir ~/workspace/personal
mkdir ~/workspace/personal/files
mkdir ~/workspace/personal/java-projects
mkdir ~/workspace/personal/node-projects
mkdir ~/workspace/personal/other-projects

echo "--------------------------------------------------------------------------"
echo "LOG - Downloading util scripts, Moving and giving exec permission"
curl -o abasteceai-exchange-setup.sh https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/base-scripts/abasteceai-exchange-setup.sh
curl -o db-import-abasteceai-local.sh https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/base-scripts/db-import-abasteceai-local.sh
curl -o docker-start.sh https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/base-scripts/docker-start.sh
curl -o edy-exchange-setup.sh https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/base-scripts/edy-exchange-setup.sh
curl -o iterative-exchange-setup.sh https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/base-scripts/iterative-exchange-setup.sh
curl -o jdk8-exchange.sh https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/base-scripts/jdk8-exchange.sh
curl -o jdk11-exchange.sh https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/base-scripts/jdk11-exchange.sh

mv *.sh ~/workspace/shell-Scripts
sudo chmod +x ~/workspace/shell-Scripts/*.sh

echo "--------------------------------------------------------------------------"
echo "LOG - Adding script files to path"
echo " " >> ~/.bashrc
echo "# Scripts Utils config" >> ~/.bashrc
echo "PATH=\$PATH:~/workspace/shell-Scripts" >> ~/.bashrc

echo "--------------------------------------------------------------------------"
echo "LOG - Downloading docker-compose"
cd ~/workspace/docker
curl -o docker-compose.yml https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/dev-tools-install/docker-compose-base/docker-compose.yml

echo "--------------------------------------------------------------------------"
echo "LOG - Downloading abasteceai files"
cd ~/workspace/abasteceai/files
curl -o settings.xml https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/files-abasteceai/settings.xml
curl -o eai-bifrost-dev.pem https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/files-abasteceai/eai-bifrost-dev.pem
curl -o aws-vpn-client-config.ovpn https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/files-abasteceai/aws-vpn-client-config.ovpn

echo "--------------------------------------------------------------------------"
echo "LOG - Downloading iterative files"
cd ~/workspace/iterative/files
curl -o IterativePFsense-UDP4-1194-ca.crt https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/files-iterative/IterativePFsense-UDP4-1194-ca.crt
curl -o IterativePFsense-UDP4-1194-config.ovpn https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/files-iterative/IterativePFsense-UDP4-1194-config.ovpn
curl -o IterativePFsense-UDP4-1194-tls.key https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/files-iterative/IterativePFsense-UDP4-1194-tls.key

echo "--------------------------------------------------------------------------"
echo "LOG - Installing nodemon"
npm install --global nodemon

echo "--------------------------------------------------------------------------"
echo "LOG - Installing nodemon"
npm install --global yarn

echo "--------------------------------------------------------------------------"
echo "Restart PC to run the second script"
echo "LOG - Edney development environment initial setup - has been finished"
echo "##########################################"
echo "##### MAIN SCRIPT - PROCESS FINISHED #####"
echo "##########################################"

echo "Moving to temporary directory"
cd /tmp || exit

echo "Creating ending file time log"
touch end-time-process-log.txt

echo "-----------------------------------------------"
echo "-----------------------------------------------"
echo ""
echo "  ***** ALL PROCESSES HAS BEEN FINISHED *****  "
echo ""
echo "-----------------------------------------------"
echo "-----------------------------------------------"

