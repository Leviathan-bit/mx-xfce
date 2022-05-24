#!/bin/sh

#Install sudo and additional package
apt install sudo wget curl zsh apt-transport-https software-properties-common -y
sudo usermod -aG sudo $USER

#Add MX21 repo
cp mx.list /etc/apt/sources.list.d/mx.list
curl http://teharris.net/mx21repo.asc -o /etc/apt/trusted.gpg.d/mx21repo.asc

#Add Brave repo
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

#install nala
echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
apt update
apt install nala -y

#Install XFCE Desktop
nala upgrade -y
nala install xfce4-appfinder xfce4-battery-plugin xfce4-datetime-plugin xfce4-diskperf-plugin xfce4-fsguard-plugin xfce4-genmon-plugin xfce4-mount-plugin xfce4-netload-plugin xfce4-notifyd xfce4-panel xfce4-places-plugin xfce4-power-manager xfce4-power-manager-data xfce4-power-manager-plugins xfce4-pulseaudio-plugin xfce4-screenshooter xfce4-session xfce4-settings xfce4-systemload-plugin xfce4-taskmanager xfce4-terminal xfce4-timer-plugin xfce4-verve-plugin xfce4-wavelan-plugin xfce4-xkb-plugin xfwm4 xfconf xfdesktop4 xfdesktop4-data thunar-archive-plugin thunar-shares-plugin thunar-data thunar-gtkhash thunar-volman thunar-custom-actions-mx network-manager network-manager-gnome network-manager-openvpn network-manager-openvpn-gnome xfce4-appmenu-plugin brave-browser plank ark mx-repo-manager mx-packageinstaller mx-remaster -y

#Deb install 
dpkg -i ./deb/ulauncher.deb

#Disable OS Prober
echo 'GRUB_DISABLE_OS_PROBER=false' >> /etc/default/grub
update-grub
