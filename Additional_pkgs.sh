
#!/bin/bash

## Vim with profile
dnf install vim
curl https://raw.githubusercontent.com/SimonTrux/etc/main/myVimrc > ~/.vimrc

## Brave stable repo and browser install
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
dnf install -y brave-browser brave-keyring

## Chrome repo and install 
dnf config-manager --set-enabled google-chrome
dnf install -y google-chrome-stable

## Install Joplin note app
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

## Gnome tweaks and extentions apps
dnf install libappindicator-gtk3 gnome-tweaks gnome-shell-extension-appindicator
