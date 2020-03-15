#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	#Update and Upgrade
	echo "Updating and Upgrading"
	apt-get update && sudo apt-get upgrade -y

	sudo apt-get install dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
	options=(1 "Media Codecs" off    # any option can be set to default to "on"
	         2 "Google Chrome" off
	         3 "Sypnatic" off
	         4 "Tweaks" off
	         5 "Gnome Extensions" off
	         6 "Firewall" off
	         7 "7zip" off
	         8 "VLC" off
	         9 "Steam" off
	         10 "GIMP" off
	         11 "Filezilla" off
	         12 "Xfburn" off
	         13 "Chromium Browser" off
	         14 "Discord" off
	         15 "Minecraft java" off
	         16 "Teamviewer" off
	         17 "laptop mode tools (can't work with TLP)" off
	         18 "Plex media player (May require logout-login)" off
			 19 "(for laptops) tlp tlp-rdw (Prefered to lmt) and powerstat" off
			 20 "Psensor" off
			 21 "LazyMan Prerequisites" off
			 22 "Docker" off
			 23 "Docker-Compose" off
			 24 "Plex Media Server" off
			 25 "Filebot (Install the license file thru Software & Update/Authentification" off
			 26 "Nvidia Latest Drivers" off
			 27 "RetroArch" off
			 28 "Lutris" off)
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
	        	1)
	            		#Install Media Codecs*
				echo "Installing Media Codecs"
				sudo apt install ubuntu-restricted-extras -y
				;;

			2)
			    	#Install Google Chrome
				echo "Installing Google Chrome"
				wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
				sudo dpkg -i google-chrome-stable_current_amd64.deb
				rm google-chrome-stable_current_amd64.deb
				;;
    		3)	
				#Install Synaptic
				echo "Installing Synaptic"
				sudo apt install synaptic -y
				;;
				
			4)
				#Install Tweaks
				echo "Installing Tweaks"
				sudo apt install gnome-tweak-tool -y
				;;

			5)
				#Install Gnome Extensions
				echo "Installing Google Chrome"
				sudo apt-get install chrome-gnome-shell -y
				;;
			6)
				#Install the firewall on start
				echo "Installing the firewall on start"
				sudo ufw enable
				echo "Installing the Firewall GUI"
				sudo apt install gufw -y
				;;
			7)
				#Install 7zip
				echo "Installing Git, please congiure git later..."
				sudo apt install p7zip-full p7zip-rar -y
				;;
			8)
				#Install VLC
				echo "Installing VLC"
				sudo apt-get install vlc -y
				;;
			9)
				#Install Steam
				echo "Installing Steam"
				sudo apt-get install steam -y
				;;
			10)
				#GIMP
				echo "Installing GIMP"
				sudo apt-get install gimp -y
				;;
			11)
				#Filezilla
				echo "Installing Filezilla"
				sudo apt install filezilla -y
				;;
			12)
				#XFBurn
				echo "Installing Xfburn"
				sudo apt-get install xfburn -y
				;;
			13)
				#Chromium Browser
				echo "Installing Chromium Browser"
				sudo apt install chromium-browser -y
				;;
			14)

				#Discord
				echo "Installing Discord"
				sudo apt install -y snapd
				sudo snap install snap-store
				sudo apt update
				sudo snap install discord
				;;
			15)

				#Minecraft java
				echo "Installing Minecraft java"
				wget -o ~/Minecraft.deb https://launcher.mojang.com/download/Minecraft.deb
				sudo apt install gdebi-core -y
				yes | sudo gdebi ~/Documents/Minecraft.deb
				;;
			16)
				#Teamviewer
				echo "Installing Teamviewer"
				wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
				sudo apt install ./teamviewer_amd64.deb -y
				rm teamviewer_amd64.deb
				;;
			17)

				#laptop tools
				echo "Installing laptop mode tools"
				sudo apt-get install laptop-mode-tools -y
				;;
			18)
				#Plex media player
				echo "Installing Flatpack"
				sudo add-apt-repository -y ppa:alexlarsson/flatpak
      				sudo apt update
      				sudo apt install flatpak -y
				echo "Installing Software Flatpak plugin"
				sudo apt install gnome-software-plugin-flatpak -y
				echo "Adding Flathub repository"
				flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
				sudo apt update
				echo "Installing Plex Media Player"
				flatpak install -y https://knapsu.eu/data/plex/tv.plex.PlexMediaPlayer.flatpakref
				;;
			19)	
				#tlp tlp-rdw prolong battery
				echo "Installing tlp tlp-rdw and powerstat"
				sudo apt install tlp tlp-rdw -y
				sudo apt update
				sudo tlp start
				sudo apt install powerstat
				;;
			20)
				#Psensor
				echo "Installing Psensor"
				sudo apt-get install psensor -y
				;;
			21)
				#LazyMan Prerequisites
				echo "Installing latest VLC and Python tools for LazyMan"
				sudo apt-get install vlc default-jdk python-setuptools python -y
				sudo apt install curl -y
				sudo apt update
				echo "Installing Streamlink for LazyMan"
				curl -O https://bootstrap.pypa.io/get-pip.py
				sudo python get-pip.py
				sudo apt update
				sudo pip install streamlink # github(.)com/StevensNJD4/LazyMan/releases and chmod +x LazyMan.jar
				;;
			22)
				#Docker
				echo "Installing Docker and autostart"
				sudo apt-get remove docker docker-engine docker.io -y
				sudo apt install docker.io -y
				sudo systemctl start docker
				sudo systemctl enable docker
				;;
			23)
				#Docker-Compose				
				echo "Installing Docker-Compose"
				sudo apt install curl
				sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
				sudo apt update
				sudo chmod +x /usr/local/bin/docker-compose
				docker-compose -v
				;;

			24)
				#Plex Media Server				
				echo "Installing Plex Media Server"
				wget https://downloads.plex.tv/plex-media-server/1.14.1.5488-cc260c476/plexmediaserver_1.14.1.5488-cc260c476_amd64.deb
				sudo dpkg -i plexmediaserver*.deb
				echo "Starting and enabling autostart"
				sudo systemctl enable plexmediaserver.service
				sudo systemctl start plexmediaserver.service
				;;
			25)
				#Filebot				
				echo "Installing Filebot"
				bash -xu <<< "$(curl -fsSL https://raw.githubusercontent.com/filebot/plugins/master/installer/deb.sh)"
				;;
			26)
				#Nividia latest drivers
				echo "Installing Nvidia PPA"
				sudo add-apt-repository ppa:graphics-drivers/ppa
				sudo apt update
				echo "Installing latest Nvidia drivers (Need Reboot After)"
				sudo ubuntu-drivers autoinstall
				;;
			27)
				#Retroarch
				echo "Installing Retroarch"
				sudo add-apt-repository ppa:libretro/stable && sudo apt-get update && sudo apt-get install retroarch*
				;;
			28)
				#Lutris
				echo "Installing Lutris PPA"
				sudo add-apt-repository ppa:lutris-team/lutris
				sudo apt update
				echo "Installing Lutris"
				sudo apt-get install lutris
				;;
	    esac
	done
fi
