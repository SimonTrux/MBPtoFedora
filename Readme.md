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

## OK : sleep (very slow wake problem) fixed now after doing some strange things :
i removed working the nvidia 470xx driver and installed the up to date xorg-x11-drv-nvidia-power.
then rebooted. DriverKO, nvidia-fallback.service make the "nouveau" kernel module load.

Then I copied services (nvidia-suspend / hibernate / resume), script and binaries installed by the 535 driver (see nvidia folder besides)
before removing the 535 driver and reinstalled the 470, rebooted and gpu working again. 

Then, I copied all service files in /usr/lib/systemd/system, and scrip and binary in /use/bin
and before doing a systemctl daemon-reload and enable new services, I wanted to ensure the sleep still doesnt work (well the 4 min to awake problem)
and miracle... close lid : 5 sec to sleep : ok like befofe
open lid : 2 seconds to awake !!,

i need to investigate more...


other tools  to watch gpu activity :
nvtop
corectrl # hum... 

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
