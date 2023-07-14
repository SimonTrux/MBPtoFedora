From MacOS to Fedora 38 on a 11,3 Macbook Pro mid 2014 with i7 and Nvidia GT750M Mac edition

Small project to ease installation
Problem encountered with 1st test build : 
1) Laggy
2) wifi not working
3) nvidia drivers not working
4) sleep problem
5) 3 fingers swap space not working anymore (worked on test build though..)

1) Keeping default partitions proposed by the Fedora installer (fs type : btrfs) since my attemps with LVM on top of ext4 partitions seemed to be problematic (worked but laggy, overall bad experience)
Then, do a `sudo rpm --rebuilddb` as with the fedora image I used it was needed before anything else.

3) Then, to address wifi problem, easy fix.
After enabling rpm fusion free and non free with :
```
sudo dnf install   https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install   https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
```
do `sudo dnf install broadcom-wl`
