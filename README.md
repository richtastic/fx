# FX
## xubuntu: life is pain


### system info

#### what is my version of xubuntu
```
cat /etc/*-release
```


#### when sources stop working and you are in pain and want to give up
```
sudo apt-get dist-upgrade
sudo apt-get upgrade
```

#### updating
```
sudo apt-get install aptitude
sudo apt-get install apt-file
sudo update-manager
```

#### changing sources
```
#  backup
sudo cp /etc/apt/sources.list /etc/apt/sources.list.2014_10_14
sudo cp -r /etc/apt/sources.list.d/ /etc/apt/sources.list.d.2014_10_14

# restore from backup (if crap goes to shit):
sudo rm /etc/apt/sources.list
sudo rm -r /etc/apt/sources.list.d/
sudo mv /etc/apt/sources.list.d.2014_10_14/ /etc/apt/sources.list.d
sudo mv /etc/apt/sources.list.2014_10_14 /etc/apt/sources.list
```

#### apt-get and dpkg bs
```
# https://smyl.es/how-to-fix-ubuntudebian-apt-get-404-not-found-package-repository-errors-saucy-raring-quantal-oneiric-natty/
# https://alselectro.wordpress.com/2014/03/30/ubuntu-13-10solution-to-broken-packages-problem/

sudo apt-get autoremove
sudo dpkg --configure -a 

# http://askubuntu.com/questions/124017/how-do-i-restore-the-default-repositories
sudo software-properties-gtk

sudo dpkg --configure -a
sudo dpkg --configure -a --force-all

sudo apt-get clean

sudo apt-get update -o Acquire::http::No-Cache=true
```


### auto-mounting drives

#### get drive UUID
```
sudo blkid /dev/sdc1
# /dev/sdc1: UUID="d836ce9e-f154-4a2b-b8a0-01f1e4012615" TYPE="ext4" 
```

#### add entry to fstab (file system table)
```
sudo vi /etc/fstab

# UUID=<partition uuid> <mount location> <file system type> <options> <dump(backup)> <pass (fsck): 1=high,2=low,0=none>
# universe
UUID=d836ce9e-f154-4a2b-b8a0-01f1e4012615  /media/phoebe/universe  ext4  defaults  0  2
```

#### example fstab file
```
# /etc/fstab: static file system information.
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sda2 during installation
UUID=705df276-d3c5-46b0-bd17-3cdbfe6aa657 /               ext4    errors=remount-ro 0       1
# /boot was on /dev/sda5 during installation
UUID=80ab151e-cf1b-4005-8e22-c8a404c122df /boot           ext4    defaults        0       2
# swap was on /dev/sda6 during installation
UUID=9b81beb4-b2ea-4b4d-86ae-dee6a5abf235 none            swap    sw              0       0

# universe
UUID=d836ce9e-f154-4a2b-b8a0-01f1e4012615 /media/phoebe/universe ext4 defaults 0 2
# legacy
UUID=7c4f5eb9-2936-491f-8e8a-f9355d2788f3 /media/phoebe/legacy ext4 defaults 0 2
# legacy 2
UUID=f36d03b0-a45b-486c-b7de-0784a75929f4 /media/phoebe/legacy2 ext4 defaults 0 2
# media
UUID=d22c41f7-91eb-4fb2-8447-4c0e7e0a4038 /media/phoebe/media ext4 defaults 0 2
```

#### linking to mounted drives in home
```
ln -s /media/phoebe/universe/universe ~/universe
ln -s /media/phoebe/media/media ~/media
```

#### moving /opt to a different drive
```
sudo mv /opt /media/phoebe/universe/universe/
sudo ln -s /media/phoebe/universe/universe/opt /opt
export PATH=$PATH:/opt
```

### drivers

#### nVidia
```
sudo apt-get install nvidia-current
sudo nvidia-settings
```


### software

#### curl
```
sudo apt-get install curl

```
#### vim
```
sudo apt-get install vim
```

#### system monitor - visual
```
sudo apt-get install gnome-system-monitor
```

#### vlc
```
sudo apt-get install vlc
```

#### dvd libs
```
sudo apt-get install libdvdread4
sudo /usr/share/doc/libdvdread4/install-css.sh
```

#### apache
```
sudo apt-get install apache2
sudo chmod 755 /media/
sudo chmod 755 /media/phoebe
sudo chmod 755 /media/phoebe/universe/
tail -f /var/log/apache2/error.log
sudo ln -s /media/phoebe/universe/repo/ff /var/www/html/ff
sudo vi /etc/apache2/apache2.conf 
...
# buncho random suggestions to try
    Options Indexes FollowSymLinks Includes ExecCGI
    Options FollowSymLinks
    AllowOverride All
    Order deny,allow
    Allow from all
    Require all granted
    Options Indexes FollowSymLinks
    AllowOverride All
...

sudo vi ./sites-available/000-default.conf
...

sudo service apache2 restart
```

#### php
```
sudo apt-get install php5
```

#### php error logging - debugging
```
ubuntu default: /var/log/apache2/error.log

# change permissions
sudo chown www-data: /var/log/php_errors.log
chmod +rw /var/log/php_errors.log
sudo chmod +rw /var/log/php_errors.log
tail -f /var/log/php_errors.log

# php settings
sudo gedit /etc/php5/apache2/php.ini

error_log = /var/log/php_errors.log
log_errors = On
track_errors = On
error_reporting = E_ALL | E_STRICT

//ini_set("log_errors", 1);
//ini_set("error_log", "/var/log/php_errors.log");
error_log("HAI - ".time());
echo "errored: ".time();

tail -f /var/log/php_errors.log
```


#### mysql
```
sudo apt-get install mysql
sudo apt-get install mysql-server mysql-client
mysql -u root -p

# RESET ROOT PASSWORD
sudo /etc/init.d/mysql stop
sudo mysqld --skip-grant-tables &
mysql -u root mysql
UPDATE user SET Password=PASSWORD('qwerty') WHERE User='root'; FLUSH PRIVILEGES; exit;

# CREATE NEW USER
mysql -u root -p
drop user richie;
create user richie identified by 'qwerty';
grant all on *.* to 'richie'@'localhost' identified by 'qwerty';
flush privileges;

# IMPORT DATA
mysql -u"richie" -p"qwerty"
create database quiz;
exit;
mysql -u"richie" -p"qwerty" quiz < ./data.sql
```

#### blender
```
# http://www.blender.org/download/
wget http://ftp.nluug.nl/pub/graphics/blender/release/Blender2.72/blender-2.72b-linux-glibc211-x86_64.tar.bz2
tar -vxf ./blender-2.72b-linux-glibc211-x86_64.tar.bz2 
mv ./blender-2.72b-linux-glibc211-x86_64 /opt/
ln -s /opt/blender-2.72b-linux-glibc211-x86_64/blender /opt/blender
sudo ln -s /opt/blender /usr/bin/blender
```

#### sublime
```
# http://www.sublimetext.com/3
wget http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3065_x64.tar.bz2
tar -vxf ./sublime_text_3_build_3065_x64.tar.bz2
mv sublime_text_3/ /opt/
ln -s /opt/sublime_text_3/sublime_text /opt/sublime
ln -s /opt/sublime /usr/bin/sublime
sudo chmod 777 ~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings 
```

#### ssh keys
```
ssh-keygen -t rsa
cat ~/.ssh/id_rsa.pub

ssh-add -D # delete all
ssh-add -l # list
ssh-add ~/.ssh/id_rsa_next_key
# https://gist.github.com/jexchan/2351996

git config user.email richie@johnrichie.com
git config user.name richie

```

#### git
```
sudo apt-get install git gitk
git clone https://github.com/richtastic/fx.git
git config --global user.name "Richie"
git config --global user.email richie@johnrichie.com

# stop asking for my username/password
vi .git/config
# [remote "origin"] ...
ssh://git@bla.com/bla/repo.git

git config --global core.editor "vim"

```

#### lftp
```
sudo apt-get install lftp
mkdir ~/.lftp
echo "set ssl:verify-certificate no" > ~/.lftp/rc
# set ssl:check-hostname no

# LFTP HOWTO
open -u usernameHere,passwordHere ftp.website.com

lpwd # LOCAL PWD
pwd # REMOTE PWD

lcd LOCAL-DIRECTORY # LOCAL CD
cd REMOTE-DIRECTORY # REMOTE CD

mirror -R LOCAL-DIRECTORY REMOTE-DIRECTORY # RECURSIVE COPY FROM LOCAL TO REMOTE
mirror REMOTE-DIRECTORY LOCAL-DIRECTORY # RECURSIVE COPY FROM REMOTE TO LOCAL
```

#### octave
```
sudo apt-get install octave
```

#### CD Ripping (WAV)
```
sudo apt-get install ripperx

```

#### audacity
```
sudo apt-get install audacity

# RECORD SYSTEM AUDIO:
$ audacity
audacity: alsa | default | default:Line0 | Stereo input
audacity: > record
$ pavucontrol
pavucontrol: > recording > dropdown: Monitor of Built-in Audio Analog Stereo
```

#### skype
```
sudo dpkg --add-architecture i386
sudp apt-get update
sudo apt-get install skype
# sudo apt-get install -f
sudo dpkg --force-depends -i ./....deb
http://askubuntu.com/questions/453368/skype-error-while-loading-shared-libraries-libxv-so-1-cannot-open-shared-obje
```

#### skype crap that was a pain in the ass
```
 sudo dpkg --force-depends -i ./skype-ubuntu-precise_4.3.0.37-1_i386.deb 

 sudo dpkg --configure -a

# https://uglyduckblog.wordpress.com/2014/01/04/solved-how-to-libv4l-0-32-bit-version-of-in-ubuntu-13-10-64-bit/
 sudo dpkg --add-architecture i386
 sudo apt-get update
 sudo apt-get install libv4l-0:i386

sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo apt-get update 
sudo apt-get install skype

# http://askubuntu.com/questions/293693/how-to-install-skype-with-ubuntu-13-04
```

#### startup USB
```
sudo apt-get install usb-creator-gtk
usb-creator-gtk
> choose from .iso
> choose to USB
```

#### formatting xubuntu drive example:
```
# find out where things are mounted
cat /proc/mounts
mount -l
# unmount partition
sudo umount /dev/sda1
# create new partition if desired
sudo fdisk /dev/sda
...
# format to ext4
mkfs.ext4 /dev/sda1
# remount
sudo mount /dev/sda1 /media/phoebe/media/
# permissions
sudo chmod -R 0777 /media/phoebe/media/
# open
thunar /media/phoebe/media/
```


#### randomize HDD
```
...
cd /media/phoebe/legacy2/legacy2/other/HDDwarez/randomize
erashure.c
```


#### formatting HDD
```
# https://ext4.wiki.kernel.org/index.php/Ext4_Howto
# show current disk info
sudo fdisk -l /dev/sdf1
...
Disk /dev/sdf: 2000.4 GB, 2000398934016 bytes
255 heads, 63 sectors/track, 243201 cylinders, total 3907029168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x55b7af33

   Device Boot      Start         End      Blocks   Id  System
/dev/sdf1              64  3907029119  1953514528    7  HPFS/NTFS/exFAT
...

# unmount
sudo umount /dev/sdf

# start fdisk
sudo fdisk /dev/sdf

# create new partition table
o

# create new partition (1)
n
# type: primary
p
# partition number
1
# first sector
2048
# last sector (half here)
1953514527

# create new partition (2)
n
# type: primary
p
# partition number
2
# first sector (start after half here)
1953514528
# last sector (end here)
<ENTER>

# list table
p
...
     Device Boot      Start         End      Blocks   Id  System
/dev/sdf1p1            2048  1953514527   976756240   83  Linux
/dev/sdf1p2      1953514528  3907029055   976757264   83  Linux
...

# change listed type (l to list all hex codes)
# 7 for HPFS/NTFS/exFAT
# first
t | 1 | 7
# second
t | 2 | 7

# write changes & quit
w

# WARNING: Re-reading the partition table failed with error 22: Invalid argument.
# The kernel still uses the old table. The new table will be used at
# the next reboot or after you run partprobe(8) or kpartx(8)
sudo partprobe # does nothing
sudo shutdown -r now # need to restart and do it all again

# when done linux SHOULD now show all the new partitions as: /dev/sdf1, /dev/sdf2, ...


# simple (fast) allocation with disk name/label
sudo mkfs.ntfs --verbose --label Antiquity --fast /dev/sdf1
sudo mkfs.ntfs --verbose --label Memento   --fast /dev/sdf2

# http://www.howtogeek.com/106873/how-to-use-fdisk-to-manage-partitions-on-linux/
# http://blog.onetechnical.com/2009/06/09/format-an-ntfs-drive-in-ubuntu/
```


#### Format info
```
format | max drive size | max file size | max no files |
----------------------
FAT16 | 4GB | 2^32 - 1 bytes | 2^16 | 
FAT32 | 32GB | 2^32 - 1 bytes | ~4 million | 
NTFS  | 2^64 alloc. units (2^32 implementation) | 2^64 bytes (2^44 bytes implementation) | 2^32 - 1
```


#### rvm | ruby | gems
```
# http://rvm.io/rvm/install
# x: sudo apt-get install  gpg | mac: brew install gpg
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source ~/.rvm/scripts/rvm

# get ruby info
rvm list
rvm list known
rvm install 2.1.2
# rvm reinstall ruby-2.2.0

# set a default ruby version
rvm alias create default ruby-2.1.2
rvm use default

# switch to system ruby
rvm use sytem

# switch to ruby version
rvm rubies
rvm use ruby-2.1.2 
rvm use ruby-2.2.0 

# gemsets - https://rvm.io/gemsets/basics
rvm gemset create default
rvm gemset use default

# show installed gems in gemset
gem list

# install gems
gem install zip mongo nokogiri bundler chef cocoapods

```







### mongo
```
# http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list
sudo apt-get update
sudo apt-get install -y mongodb-org

# service
sudo service mongod stop
sudo service mongod start

# notes
show dbs
user mydatabasenamehere
show collections
db["mycollnamehere"].findOne()

```


#### virtualbox
```
sudo apt-get install virtualbox
sudo usermod -a -G vboxusers phoebe
# install guest editions via interface
...
```

#### chromium | unstable-chromium
```
sudo apt-get install chromium-browser
# unstable because of nvidia drivers
# http://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-unstable
wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-unstable/google-chrome-unstable_40.0.2214.6-1_amd64.deb
dpkg -i ./google-chrome-unstable_40.0.2214.6-1_amd64.deb
google-chrome-unstable
```

#### Brasero
```
sudo apt-get install cdrdao bchunk
toc2cue yourfile.toc yourfile.cue
bchunk yourfile.bin yourfile.cue yourfile.iso
```

#### 3D Printing - Makerbot
```
# http://support.makerbot.com/learn/makerbot-desktop-software/installation-and-setup/how-to-install-makerbot-desktop-for-linux_11262
sudo apt-add-repository "http://downloads.makerbot.com/makerware/ubuntu"
wget http://downloads.makerbot.com/makerware/ubuntu/dev@makerbot.com.gpg.key
sudo apt-key add dev@makerbot.com.gpg.key
sudo apt-get install makerware
makerware
```


#### image tools - some of these suck, but what are you gonna do
```
sudo apt-get install imagemagick
# brew install imagemagick

convert ./....

# grayscale
convert in.jpg -colorspace Gray out.png # grayscale
convert in.jpg -monochrome out.png # B&W dotted
convert in.jpg -separate outRGB.png # red | green | blue as greyscale

```

#### image compression
```
sudo apt-get install trimage
trimage -f ./main.png 

# https://github.com/pornel/pngquant
apt-get install libpng-dev
git clone https://github.com/pornel/pngquant.git
cd pngquant
./configure
make
./pngquant ../examples/main.png -o ../examples/mainquant.png


# http://pmt.sourceforge.net/pngcrush/
make
./pngcrush


# https://github.com/JamieMason/ImageOptim-CLI
# https://github.com/technopagan/adept-jpg-compressor
# https://github.com/kud/jpegrescan
# http://googledevelopers.blogspot.co.uk/2013/02/compress-data-more-densely-with-zopfli.html
# 
# 
```


#### terminal prompt
```
# PS1
```

#### vim cheat sheet
```
UNDO       u
REDO       ctr+R
```

#### vim color schemes
```
fifk
```


#### RECORDING DESKTOP SW
```
# http://www.maartenbaert.be/simplescreenrecorder/
sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder
sudo apt-get update
sudo apt-get install simplescreenrecorder
# if you want to record 32-bit OpenGL applications on a 64-bit system:
sudo apt-get install simplescreenrecorder-lib:i386

# something else
sudo apt-get install recordmydesktop 
```

### AUDIO STUFFS:
```
gnome-control-center sound

sudo apt-get install xfce4-mixer    indicator-sound-gtk2

pulseaudio -k

sudo apt-get install paprefs 

xfce4-mixer
sudo apt-get install xfce4-mixer

alsamixer
```


#### video input / vhs stuff
```
sudo apt-get install tvtime
sudo apt-get install transcode
# http://ubuntuforums.org/showthread.php?t=921233
sudo apt-get install gnome-terminal

...

v4l-info
sudo apt-get install v4l-conf
```


### terminal / shell color themes
```
...
```


### run command periodically
```
watch -n 1   ls .
```


### git
```
sudo apt-get install git
# force untracked files overwrite:
git fetch --all
git reset --hard origin/master 

# example project/.gitignore

```

#### start a repo
```
mkdir fx
cd fx
git config --local user.email "richie@johnrichie.com"
git config --local user.name "richtastic"
git init
vi README.md
git add ./README.md
git commit -m"fx"
git remote add origin https://github.com/richtastic/fx.git
git push -u origin master
```

#### start an .io project page
```
mkdir ff_project
cd ff_project/
git clone git@github.com:richtastic/ff.git
cd ff
git checkout --orphan gh-pages
git rm -rf .

echo "My Page" > index.html
git add index.html
git commit -a -m "First pages commit"
git push origin gh-pages

https://richtastic.github.io/ff
```


#### xinerama | nvidia | xorg.conf
```
# /etc/X11/xorg.conf
# Device: ~graphics card ports
# Monitor: ~physical monitor display-device
# Screen: ~connect a device to a monitor
# Display: (Screen subsection) ~display attributes
# nvidia-settings: X configuration file generated by nvidia-settings
# nvidia-settings:  version 343.13  (buildd@lgw01-30)  Mon Aug 11 19:50:14 UTC 2014

Section "Files"
EndSection

Section "InputDevice"
    Identifier     "Mouse0"
    Driver         "mouse"
    Option         "Protocol" "auto"
    Option         "Device" "/dev/psaux"
    Option         "Emulate3Buttons" "no"
    Option         "ZAxisMapping" "4 5"
EndSection

Section "InputDevice"
    Identifier     "Keyboard0"
    Driver         "kbd"
EndSection

Section "Monitor"
    # HorizSync source: edid, VertRefresh source: edid
    Identifier     "Monitor0"
    VendorName     "Unknown"
    ModelName      "SAMSUNG"
    HorizSync       15.0 - 81.0
    VertRefresh     24.0 - 75.0
    Option         "DPMS"
EndSection

Section "Monitor"
    # HorizSync source: unknown, VertRefresh source: unknown
    Identifier     "Monitor1"
    VendorName     "Unknown"
    ModelName      "Wacom Tech Cintiq21UX"
    HorizSync       31.0 - 92.0
    VertRefresh     56.0 - 85.0
    Option         "DPMS"
EndSection

Section "Monitor"
    # HorizSync source: unknown, VertRefresh source: unknown
    Identifier     "Monitor2"
    VendorName     "Unknown"
    ModelName      "SAMSUNG"
    HorizSync       15.0 - 81.0
    VertRefresh     24.0 - 75.0
    Option         "DPMS"
EndSection

Section "Monitor"
    Identifier     "Monitor3"
    VendorName     "Unknown"
    ModelName      "SAMSUNG"
    HorizSync       15.0 - 81.0
    VertRefresh     24.0 - 75.0
EndSection



Section "Device"
    Identifier     "Device0"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    BoardName      "GeForce GTS 450"
    BusID          "PCI:1:0:0"
    Screen          0
EndSection

Section "Device"
    Identifier     "Device1"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    BoardName      "GeForce GTX 550 Ti"
    BusID          "PCI:4:0:0"
    Screen          0
EndSection

Section "Device"
    Identifier     "Device2"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    BoardName      "GeForce GTX 550 Ti"
    BusID          "PCI:4:0:0"
    Screen          1
EndSection

Section "Device"
    Identifier     "Device3"
    Driver         "nvidia"
    VendorName     "NVIDIA Corporation"
    BoardName      "GeForce GTS 450"
    BusID          "PCI:1:0:0"
    Screen          1
EndSection



Section "Screen"
# Removed Option "metamodes" "DVI-I-2: nvidia-auto-select +0+0, HDMI-0: nvidia-auto-select +1920+0"
    Identifier     "Screen0"
    Device         "Device0"
    Monitor        "Monitor0"
    DefaultDepth    24
    Option         "Stereo" "0"
    Option         "metamodes" "DVI-I-2: nvidia-auto-select +0+0"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    SubSection     "Display"
        Depth       24
        Viewport    0 0
        Modes      "1920x1080"
        Virtual    1920 1080
    EndSubSection
EndSection

Section "Screen"
    Identifier     "Screen1"
    Device         "Device1"
    Monitor        "Monitor1"
    DefaultDepth    24
    Option         "Stereo" "0"
#    Option         "nvidiaXineramaInfoOrder" "CRT-0"
    Option         "metamodes" "DVI-I-0: nvidia-auto-select +0+0"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    SubSection     "Display"
        Depth       24
        Viewport    0 0
        Modes      "1600x1200"
        Virtual    1600 1200
    EndSubSection
EndSection

Section "Screen"
    Identifier     "Screen2"
    Device         "Device2"
    Monitor        "Monitor2"
    DefaultDepth    24
    Option         "Stereo" "0"
    Option         "metamodes" "HDMI-0: nvidia-auto-select +0+0"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    SubSection     "Display"
        Depth       24
        Viewport    0 0
        Modes      "1920x1080"
        Virtual    1920 1080
    EndSubSection
EndSection

Section "Screen"
    Identifier     "Screen3"
    Device         "Device3"
    Monitor        "Monitor3"
    DefaultDepth    24
    Option         "Stereo" "0"
    Option         "metamodes" "HDMI-0: nvidia-auto-select +0+0"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    SubSection     "Display"
        Depth       24
        Viewport    0 0
        Modes      "1920x1080"
        Virtual    1920 1080
    EndSubSection
EndSection


Section "ServerLayout"
    Identifier     "Layout0"
    Screen      0  "Screen0" 0 0
    Screen      1  "Screen1" 5760 0
    Screen      2  "Screen2" 3840 0
    Screen      3  "Screen3" 1920 0
#    Screen      0  "Screen0" 0 0
#    Screen      1  "Screen1" RightOf "Screen2"
#    Screen      2  "Screen2" RightOf "Screen1"
#    Screen      3  "Screen3" RightOf "Screen0"
    Option         "Xinerama" "true"
    InputDevice    "Keyboard0" "CoreKeyboard"
    InputDevice    "Mouse0" "CorePointer"
EndSection

```


#### xubuntu default applications
```
sudo chmod 775 ~/.local/share/applications
~/.local/share/applications/mimeapps.list 
~/.local/share/applications/defaults.list
```


#### faster ui
```
vi ~/.gtkrc-2.0
# .gtkrc-2.0
gtk-menu-popup-delay = 0 
gtk-menu-popdown-delay = 0 
gtk-menu-bar-popup-delay = 0 
gtk-enable-animations = 0 
gtk-timeout-expand = 0
gtk-timeout-initial = 0
gtk-timeout-repeat = 0
```



### TO RECORD VHS:
- hook all inputs (audio/video) into conversion device
- hook in USB into slot, and mic into mic slot
    - to make sure linux is getting a video signal, run: ls /dev/video0
- in terminal, run:  tvtime --g 1200x900 [--input=1]
    - example dimensions are:
       - 1.777: 640x360, 800x450, 880x495, 928x522
       - 1.333: 400x300, 480x360, 800x600, 1000x750, 1200x900
    - place tvtime screen in location on desktop to be recorded
    (if blank screen, it might be grabbing source s-video or V/L/R, append "--input=1" to command)

- in another terminal, run: xfce4-mixer
    - we want to make sure audio is output thru the system
    - maximize "Rear Mic" (or whatever plug you put the audio jack into)
    - minimize "Rear Mic Boost" (to remove BG hissing)

- in another terminal, run: simplescreenrecorder
    - select window to record (tvtime window)
    - record the input audio channel [here: Built-in Audio Analog Stereo]
    - select file to save to (browse to directory and name: out.mp4)
    - select video format: MP4
        - checkmark 'seperate file per segment'
    - select audio format: AAC 128bps
    - show preview to make sure audio and video are as expected

- DON'T TOUCH ANYTHING WHILE RECORDING

- When done, pause recording, and save recording to disk

- convert using ffmpeg in another terminal: (mess with settings)
    ffmpeg -i ./input.mkv -b 4000k -minrate 4000k -maxrate 4000k output.avi

- edit in blender

EXAMPLE SETS:
    HOME MOVIES:
        1200x900, mp4+seperate+H.264+rate=24+fast+allow-skip, AAC+128



#### FFMPEG:
```
# no longer in default repos or whatever
sudo add-apt-repository ppa:jon-severinsson/ffmpeg
sudo apt-get update
sudo apt-get install ffmpeg
sudo apt-get install frei0r-plugins
# https://www.ffmpeg.org/ffmpeg.html
ffmpeg -i input.mkv output.avi
ffmpeg -i infile.wmv out.mpeg
ffmpeg -i ./boot.wmv -qscale 0 boot.mpeg
ffmpeg -i ./boot.wmv -b 500k boot.mpeg
```

#### AVCONV
```
# wtf
avconv -i input.mkv -codec copy output.mp4
```

#### MENCODER:
```
# wtf
http://www.thelinuxguy.nl/how-tos/how-to-convert-mkv-movies-via-terminal/
mencoder nameofthemovie.mkv -vf scale=800:430 -ovc xvid -oac copy -xvidencopts bitrate=1200 -sid 1 -of avi -o nameofthemovie.avi
```


#### References
```
http://www.binarytides.com/better-xubuntu-14-04/

```


#### gawddamn scroll wheel
```
sudo apt-get install imwheel
killall imwheel
imwheel --config
vi ~/.imwheelrc
imwheel
# .imwheelrc
".*"
None,       Up,     Button4,   5
None,       Down,   Button5,   5
```




=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
v v v v THIS NEEDS TO BE REVIEWED BEFORE INTEGRATING v v v v
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=




```
# AUTO MOUNT DRIVES - http://www.johnrichie.com/zoe/index.php?action=viewPosts&page=1&topic=284
sudo vi /etc/fstab
ROOT: 0a5b5f9c-4c15-4f29-8075-6d685dfed68a (sdb3)
HOME: 70809f69-0aad-488f-9d6c-969f706601b8 (sdb4)

# CREATE SWAP FILE (/swapfile0)
sudo dd if=/dev/zero of=/swapfile0 bs=1024 count=83388608
mkswap /swapfile0
chown root:root /swapfile0
chmod 0600 /swapfile-
swapon /swapfile
vi /etc/fstab
>>> ADD LINE: /swapfile0 swap swap defaults 0 0

sudo dd if=/dev/zero of=/swapfile0 bs=1024 count=83388608

# LINK TEMP DIRECTORY TO STANDARD HDD
sudo rm /tmp
sudo ln -s /home/tmp /tmp

# LINK HOME DIRECTORY TO STANDARD HDD
70809f69-0aad-488f-9d6c-969f706601b8

# VIM
sudo apt-get install vim
vi ~/.vimrc
highlight comment ctermfg=lightblue
# CHROME
sudo apt-get install chromium-browser
# SYSTEM MONITOR
sudo apt-get install gnome-system-monitor
# SYNAPTIC
sudo apt-get install synaptic
#RESTRICTED
sudo apt-get install xubuntu-restricted-extras
sudo /usr/share/doc/libdvdread4/install-css.sh
# JAVA - http://www.ubuntugeek.com/how-to-install-oracle-java-7-in-ubuntu-12-04.html
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer
? http://openjdk.java.net/install
# MEDIA PLAYER
sudo apt-get install vlc
sudo apt-get install totem
# MINECRAFT:
google minecraft
java -jar Minecraft.jar
# MINECRAFT 2
http://www.technicpack.net/download
# TEAMSPEAK:
google teamspeak, download, run ./run, executable
# STEAM:
https://developer.valvesoftware.com/wiki/Steam_under_Linux
#BLENDER
blender.com
#VIRTUALBOX
sudo apt-get install virtualbox
    # latest version

#GIT
sudo apt-get install git
#APACHE2:  http://www.howtogeek.com/howto/ubuntu/installing-php5-and-apache-on-ubuntu/
sudo apt-get install apache2
#PHP5
sudo apt-get install php5
sudo apt-get install libapache2-mod-php5
sudo /etc/init.d/apache2 restart
#MYSQL
#SQLITE

#MONGO

# FLASH PLAYER ...........................................................................................
uname -a
http: http://get.adobe.com/flashplayer/?no_redirect
adobe-flashplugin

# FIX 1: http://grumpymole.blogspot.com/2006/10/ubuntu-firefox-flash-crash-this-fix.html
sudo vi /usr/bin/firefox
# MOZ_PROGRAM=...
export XLIB_SKIP_ARGB_VISUALS=1

# ATTEMPT 2: http://askubuntu.com/questions/122306/flash-does-not-work-with-the-latest-update
wget http://archive.canonical.com/pool/partner/a/adobe-flashplugin/adobe-flashplugin_10.2.159.1-0natty1_i386.deb
sudo dpkg -i adobe-flashplugin_10.2.159.1-0natty1_i386.deb
OR
wget http://archive.canonical.com/pool/partner/a/adobe-flashplugin/adobe-flashplugin_10.2.159.1.orig.tar.gz
cp libflashplayer.so to /usr/lib/flashplugin-installer/

sudo apt-get remove flashplayer

http://www.omgubuntu.co.uk/2012/02/adobe-adandons-flash-on-linux/

older version of Flash (11.1)

XFCE: http://mirror.pnl.gov/ubuntu//pool/universe/x/xfce4-session/xfce4-session_4.10.0-2ubuntu1_amd64.deb


dpkg -l | grep -i flash

 xfce4-session 

http://support.mozilla.org/en-US/kb/install-firefox-linux

http://www.everydaylinuxuser.com/2012/12/20-applications-to-improve-xubuntu.html

https://bugs.launchpad.net/ubuntu/+source/xfce4-session/+bug/1104435

sudo apt-get upgrade
sudo apt-get dist-upgrade




# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
# / was on /dev/sda5 during installation
UUID=a2437ead-de3f-4394-adab-a91684be160f /               ext4    errors=remount-ro 0       1
# /boot was on /dev/sda1 during installation
UUID=666dc558-3d17-4ade-a2ee-5736bad385bf /boot           ext4    defaults        0       2

# ADDED FOR MOUNTING 'OLD DRIVES' -RICHIE
UUID=70809f69-0aad-488f-9d6c-969f706601b8 /home ext4 defaults 0 0
#/dev/sdb4 /media/elektron/70809f69-0aad-488f-9d6c-969f706601b8 ext4 rw,nosuid,nodev,uhelper=udisks2 0 0





# CREATE SWAP FILE (/home/swapfile0) - http://www.cyberciti.biz/faq/linux-add-a-swap-file-howto/
sudo dd if=/dev/zero of=/home/swapfile0 bs=1024 count=8388608
sudo mkswap /home/swapfile0
sudo chown root:root /home/swapfile0
sudo chmod 0600 /home/swapfile0
sudo swapon /home/swapfile0
sudo vi /etc/fstab
>>> ADD LINE: /home/swapfile0 swap swap defaults 0 0
sudo shutdown -r now
free -m

```


# CUT A FILE UP TO MULTIPLE BINARIES:
```
cd ~/tempFolder
split  -b 100m  -a 8  -d  --verbose  ~/myfile.bin
cat ./x* > ~/myfile.bin
`


# WORDPRESS
https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-on-ubuntu-14-04



### additional SW
```
sudo apt-get install php5-gd libssh2-php
sudo apt-get install php5-mysql
```

### include sql in php
```
vi /etc/php5/apache2/php.ini
# extension_dir = "/usr/lib/php5/20131226"
# extension=mysql.so
```

### create db user pass
```
mysql -u root -p
create database wordpress;
create user wordpressuser@localhost identified by 'qwerty';
grant all privileges ON wordpress.* to wordpressuser@localhost;
flush privileges;
exit
```

### install wordpress
```
cd ~/Downloads/

wget http://wordpress.org/latest.tar.gz

tar xzvf latest.tar.gz

cp -r ./wordpress /var/www/html/wp


cd /var/www/httl/wp
cp wp-config-sample.php wp-config.php
vi wp-config.php # db user pass
#sudo rsync -avP ~/wordpress/ /var/www/html/
```


```
# /etc/php5/apache2/php.ini
extension=mysql.so
...
extension_dir = "/usr/lib/php5/20151012"
```

### debug tests
```
php -v # php errors/warnings
sudo /etc/init.d/apache2 restart
/etc/init.d/mysql start
/etc/init.d/mysql status
dpkg --list | grep php5-mysql
```


### TOOLS:
```
# PHP PARSER CHECKER
http://phpcodechecker.com/
# JSON PARSER CHECKER
jsonlint.com
# 

```




