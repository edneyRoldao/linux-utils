#!/bin/bash

echo "##########################################################################"
echo "##### Edney development environment initial setup - has been started #####"
echo "##########################################################################"

echo "--------------------------------------------------------------------------"
echo "LOG - Setting up my SSH key ..."
mkdir ~/.ssh
echo "-----BEGIN RSA PRIVATE KEY-----" >> ~/.ssh/id_rsa
echo "MIIEowIBAAKCAQEAtko3zeKEIajlmZV6kjqyXEvGnAHk3vusnTLWMB74tvXO/25d" >> ~/.ssh/id_rsa
echo "/cLg5faXpTiO909gxAdOhbHGux3EtxjDiBeOtU6vSOukeH0XzUgNYahIN+mb3RTz" >> ~/.ssh/id_rsa
echo "+M+5I3w9Sdldh7vKqlqg2FxlUV8a7GFOU9wzdtidr3turL9XssU5EIP4+ZxSByV3" >> ~/.ssh/id_rsa
echo "CJS1rzuava1GKP0aEkmM8laui+W9K9WwfUufjcdSksO+a1ZjXIAJzLxw1qsgYSpe" >> ~/.ssh/id_rsa
echo "sEIq+WadPXW+7XpWfmTNXyTobZbyT0DY+QnTsFyryR0n7UKQuyovAxEkq/h2hCWN" >> ~/.ssh/id_rsa
echo "GSbLWkmIaBBPCyjKUk9XD4qInRhxxDSJFVb9PQIDAQABAoIBAFlGP841AUD61ndB" >> ~/.ssh/id_rsa
echo "HaY/2NoawknlI5GQ8BiMrRkkEeqIt7eg9acxqbL18Y6ZBGtaFKnsaihPyGQbUBvb" >> ~/.ssh/id_rsa
echo "pOchomJpBq9PuFzJ5r5Ca0tIfxXi8tJzUIiqMqGOVvWz3np7HeYQPHW5ymTvjt/1" >> ~/.ssh/id_rsa
echo "R8cKMKojrBYk/S7dBrYmoKvV9jlH4cvy42Q5sX+RTpsf04G67vRqtou0rHNxKQoD" >> ~/.ssh/id_rsa
echo "t09WQ9gIPyl7zoPEVo7aKp/+wSN50N7uWtns5hjygA/nPZRlbBXs2lv8PBeyT37G" >> ~/.ssh/id_rsa
echo "wLWNzQvQR9YUgdyHBRUvvb16Qow0SsRsfT7l8gzrLtwmrNNFlB+WZniuvqiFfUVx" >> ~/.ssh/id_rsa
echo "91/XhoECgYEA2PFqz6xIPsDfwxFVO7UvTOnYYtDRP9OHDyIFGP/bZcBEvlLcx7y4" >> ~/.ssh/id_rsa
echo "K/NxGMUDkxKH9U5pXw0qEv82kOXmE1vmmVFJBSHhej6Mt1YW13AP/v0BQm8KOpsU" >> ~/.ssh/id_rsa
echo "QLnOBkf1bRfbcPcAHdm7dTxBVZOLy9pyrYK+8MVtKl5fBFFCb9UuKRsCgYEA1xuw" >> ~/.ssh/id_rsa
echo "k8dD3lrPmxVipNtQWSi/bx7hH8m+rQ5Oqrxfe4oIIwoWgEG848uzXUvLfUUSKRbY" >> ~/.ssh/id_rsa
echo "BO5TkCVhnpJ2S2FQWnAJRoKBxVCdsswQve1sJ7PjjMdX55HrLE2CSxUDuZGiU3S2" >> ~/.ssh/id_rsa
echo "pkmaa2gScQx/Vg/lBERgn1d5EPqLLxWp5IfC8IcCgYEAjH471+YQm2M5BhERi6tY" >> ~/.ssh/id_rsa
echo "yIygb84f1R/d1XUIrBn2Mb0ER+VNyaRz+TKcyZe9Kt/TYI+5Oa9C0i6pXckk6OCZ" >> ~/.ssh/id_rsa
echo "RC0aBtLcPNiJNKnx/O87zLx4tldG3pFT2l76B6NOU6ohmNS9JJe/CLtO7GazH/+G" >> ~/.ssh/id_rsa
echo "SMvlb/PLMKcRDbC6P8ZlMIUCgYAreSglpab8wEOm5xqJkN1bN5YA4i/DWeWUWgji" >> ~/.ssh/id_rsa
echo "DrIJaKseUcKcZyzCqP92AoR8q8Hw1fIQhQ4UWsmw347SyzcPIAdv3Z5Wf2VvpjhX" >> ~/.ssh/id_rsa
echo "+izalUuOvxbv8RijWoLTo8qd7WXuEe98CfIQdPcNK+ZsQUgapasVaPtJyCjq+ijc" >> ~/.ssh/id_rsa
echo "y+dE7wKBgCC95JZwOY5V9ACNofkWZsPJaSYhF81hNg2abqr37qGUbxXWQtkQk9U+" >> ~/.ssh/id_rsa
echo "rgWQbH1TIZmmuMeFUXVll/rm1J5yxCx3FC4cTT+J8usgRRPVJiLSga/FSxJ1K5Db" >> ~/.ssh/id_rsa
echo "6dHG29icn8Q6Zg5P5pOBT7cTqVPF6guN0L64taPbq0WKPjuGeNO9" >> ~/.ssh/id_rsa
echo "-----END RSA PRIVATE KEY-----" >> ~/.ssh/id_rsa
echo "" >> ~/.ssh/id_rsa

curl -o id_rsa.pub https://sdk-ecommerce.herokuapp.com/secret-keys/edy/ssh/public --header "API_KEY: "$SSH_API_KEY""
echo "" >> id_rsa.pub
mv id_rsa.pub ~/.ssh/

chmod 700 ~/.ssh
chmod 600 ~/.ssh/*

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
mkdir ~/workspace/abasteceai
mkdir ~/workspace/speedy
mkdir ~/workspace/commons-files
mkdir ~/workspace/java-projects
mkdir ~/workspace/javascript-projects
mkdir ~/workspace/personal
mkdir ~/workspace/personal/java-projects
mkdir ~/workspace/personal/javascript-projects

echo "--------------------------------------------------------------------------"
echo "LOG - Downloading util scripts, Moving and giving exec permissions"
curl -o edy-exchange-setup.sh https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/base-scripts/edy-exchange-setup.sh
curl -o ipiranga-exchange-setup.sh https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/base-scripts/ipiranga-exchange-setup.sh
curl -o iterative-exchange-setup.sh https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/base-scripts/iterative-exchange-setup.sh
curl -o speedy-exchange-setup.sh https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/base-scripts/speedy-exchange-setup.sh
curl -o docker-start.sh https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/personal-scripts/base-scripts/docker-start.sh
mv *exchange-setup*.sh ~/workspace/shell-Scripts
mv docker-start.sh ~/workspace/shell-Scripts
sudo chmod +x ~/workspace/shell-Scripts/*.sh

echo "--------------------------------------------------------------------------"
echo "LOG - Adding script files to path"
echo " " >> ~/.bashrc
echo "# Scripts Utils config" >> ~/.bashrc
echo "PATH=\$PATH:~/workspace/shell-Scripts" >> ~/.bashrc

echo "--------------------------------------------------------------------------"
echo "LOG - Cloning personal projects"
cd ~/workspace/personal/java-projects
git clone git@github.com:edneyRoldao/spring-data-unit-tests-samples.git
git clone git@github.com:edneyRoldao/open-feign-tests.git
git clone git@github.com:edneyRoldao/rabbitmq-with-spring.git
cd ~/workspace/personal/javascript-projects
git clone git@github.com:edneyRoldao/aulas-modulo-1.git
git clone git@github.com:edneyRoldao/sdk-ecommerce.git

echo "--------------------------------------------------------------------------"
echo "LOG - Iterative projects"
cd ~/workspace/java-projects
git clone git@ssh.dev.azure.com:v3/IterativeProjetos/RoadCard/rntrc-back-pedidos
git clone git@ssh.dev.azure.com:v3/IterativeProjetos/RoadCard/rntrc-back-admin
git clone git@ssh.dev.azure.com:v3/IterativeProjetos/RoadCard/rntrc-back-oauth
cd ~/workspace/javascript-projects
git clone git@ssh.dev.azure.com:v3/IterativeProjetos/RoadCard/rntrc-front

echo "--------------------------------------------------------------------------"
echo "LOG - Abastece-ai projects"
cd ~/workspace/java-projects
git clone git@gitlab.eai.com.br:project-grups/wallet/core.git
git clone git@gitlab.eai.com.br:project-grups/wallet/payment-new.git
git clone git@gitlab.eai.com.br:project-grups/wallet/backoffice-new.git
git clone git@gitlab.eai.com.br:project-grups/wallet/commons-lib-new.git
git clone git@gitlab.eai.com.br:project-grups/wallet/partner-services.git
git clone git@gitlab.eai.com.br:project-grups/wallet/ecommerce-service-provider.git
cd ~/workspace/javascript-projects
git clone git@gitlab.eai.com.br:project-grups/wallet/ecommerce-api-gateway.git
git clone git@gitlab.eai.com.br:project-grups/wallet/ecommerce-sdk.git
git clone git@gitlab.eai.com.br:project-grups/wallet/partner-api-gateway.git
git clone git@gitlab.eai.com.br:project-grups/wallet/mobile-api-gateway.git

echo "--------------------------------------------------------------------------"
echo "LOG - Downloading docker-compose"
cd ~/workspace/docker
curl -o docker-compose.yml https://raw.githubusercontent.com/edneyRoldao/linux-utils/main/dev-tools-install/docker-compose-base/docker-compose.yml


echo "--------------------------------------------------------------------------"
echo "LOG - Personal config has been finished ..."

