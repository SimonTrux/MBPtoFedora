From MacOS to Fedora 38 on a 11,3 Macbook Pro mid 2014 with i7 and Nvidia GT750M Mac edition

Small project to ease installation
Problem encountered with 1st test build : 
1) Laggy
2) wifi not working
3) nvidia drivers not working
4) sleep problem
5) 3 fingers swap space not working anymore (worked on test build though..)

1) Keeping default partitions proposed by the Fedora installer (fs type : btrfs) since my attemps with LVM on top of ext4 partitions seemed to be problematic (worked but laggy, overall bad experience)

   After first start, do a `sudo rpm --rebuilddb` as with the fedora image I used it was needed before anything else. Then you can `sudo dnf update` all packages.

2) Then, to address wifi problem, easy fix.
After enabling rpm fusion free and non free with :
```
sudo dnf install   https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install   https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```
do `sudo dnf install broadcom-wl` (there will be many dependencies).
After next reboot you'll have wifi working.

3) Nvidia drivers : Ive tried many things before finding that simple one that works for that configuration : `sudo dnf install xorg-x11-drv-nvidia-470xx`

I've tried to manually install the official driver from nvidia website that should be supporting my GPU, the ...v418.run, tried the v535 from dnf, with no luck, only the 470xx works.

4) The sleep problem : On it right now...


apparently there a fix for it in the suspend section of https://rpmfusion.org/Howto/NVIDIA
```
sudo dnf -y install xorg-x11-drv-nvidia-power
sudo systemctl enable nvidia-{suspend,resume,hibernate}
# Optional: tweak "nvidia options NVreg_TemporaryFilePath=/var/tmp" from /etc/modprobe.d/nvidia.conf as needed if you have issue with /tmp as tmpfs with nvidia suspend )
```
other tools  to watch gpu activity :
nvtop
corectrl

radeontop

To summarize, a script like this, run as root, should do the job :

```
#!/bin/bash

# General
rpm --rebuilddb
dnf update -y

# for wifi and nvidia drivers
dnf install -y \
  https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf install -y broadcom-wl xorg-x11-drv-nvidia-470xx

```
