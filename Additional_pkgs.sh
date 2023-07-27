#!/bin/bash

## Vim with profile
dnf install -y vim
curl https://raw.githubusercontent.com/SimonTrux/etc/main/myVimrc > ~/.vimrc

## Brave stable repo and browser install
dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
dnf install -y brave-browser brave-keyring

## Chrome repo and install 
dnf config-manager --set-enabled google-chrome
dnf install -y google-chrome-stable

## Install Joplin note app
wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

## Microsoft vscode
rpm --import https://packages.microsoft.com/keys/microsoft.asc

cat <<EOF | sudo tee /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

dnf install -y code

# gitlab runner
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh | sudo bash
#dnf install -y gitlab-runner

## Graphics (disabled by default) : gimp (PS), inkscape (AI), darktable (LR)
# dnf install -y gimp inkscape darktable

## Gnome tweaks and extentions apps
dnf install -y libappindicator-gtk3 gnome-tweaks gnome-shell-extension-appindicator


## Utilities
dnf install -y powertop mbpfan

## Cleanup of gnome packages
dnf remove -y gnome-weather gnome-tour gnome-maps
