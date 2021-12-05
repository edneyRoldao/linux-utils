echo "##################################################"
echo "### DBEAVER - install process has been started ###"
echo "##################################################"

echo "LOG - Downloading dbeaver-ce ..."

wget https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb
sudo dpkg -i dbeaver-ce_latest_amd64.deb
sudo rm -f dbeaver-ce_latest_amd64.deb

echo "LOG - dbeaver-ce install process finished"

