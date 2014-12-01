# FX
## xubuntu: live is pain


apt-get dist-upgrade

elektron@nucleus:~/Downloads$ sudo apt-get install aptitude


### System information

#### what is my version of xubuntu
```
cat /etc/*-release
```






#### Updating, I dunno
```
sudo update-manager
```

```
sudo apt-get install apt-file
```


### Changing sources
```
# copies to backup
sudo cp /etc/apt/sources.list /etc/apt/sources.list.2014_10_14
sudo cp -r /etc/apt/sources.list.d/ /etc/apt/sources.list.d.2014_10_14

# restore from backup (only if crap goes to shit):
sudo rm /etc/apt/sources.list
sudo rm -r /etc/apt/sources.list.d/
sudo mv /etc/apt/sources.list.d.2014_10_14/ /etc/apt/sources.list.d
sudo mv /etc/apt/sources.list.2014_10_14 /etc/apt/sources.list
```



### auto-mounting drives
#### get drive UUID
```
$ sudo blkid /dev/sdc1
/dev/sdc1: UUID="d836ce9e-f154-4a2b-b8a0-01f1e4012615" TYPE="ext4" 
```
#### add entry to fstab (file system table)
```
$ sudo vi /etc/fstab

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

### moving /opt to a different drive
```
sudo mv /opt /media/phoebe/universe/universe/
sudo ln -s /media/phoebe/universe/universe/opt /opt
export PATH=$PATH:/opt
```


## drivers

### nVidia
```
sudo apt-get install nvidia-current
sudo nvidia-settings
```

## software

### CURL
```
sudo apt-get install curl

```
### vim
```
sudo apt-get install vim
```

### system monitor - visual
```
sudo apt-get install gnome-system-monitor
```

### vlc
```
sudo apt-get install vlc
```

### dvd libs
```
sudo apt-get install libdvdread4
sudo /usr/share/doc/libdvdread4/install-css.sh
```

### blender
```
# http://www.blender.org/download/
wget http://ftp.nluug.nl/pub/graphics/blender/release/Blender2.72/blender-2.72b-linux-glibc211-x86_64.tar.bz2
tar -vxf ./blender-2.72b-linux-glibc211-x86_64.tar.bz2 
mv ./blender-2.72b-linux-glibc211-x86_64 /opt/
ln -s /opt/blender-2.72b-linux-glibc211-x86_64/blender /opt/blender
sudo ln -s /opt/blender /usr/bin/blender
```

### sublime
```
# http://www.sublimetext.com/3
wget http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3065_x64.tar.bz2
tar -vxf ./sublime_text_3_build_3065_x64.tar.bz2
mv sublime_text_3/ /opt/
ln -s /opt/sublime_text_3/sublime_text /opt/sublime
ln -s /opt/sublime /usr/bin/sublime
```

### git
```
sudo apt-get install git gitk
git clone https://github.com/richtastic/fx.git
git config --global user.name "Richie"
git config --global user.email richie@johnrichie.com
```


### octave
```
sudo apt-get install octave
```

### audacity
```
sudo apt-get install audacity
```

### Skype
```
sudo dpkg --add-architecture i386
sudp apt-get update
sudo apt-get install skype
# sudo apt-get install -f
sudo dpkg --force-depends -i ./....deb
http://askubuntu.com/questions/453368/skype-error-while-loading-shared-libraries-libxv-so-1-cannot-open-shared-obje
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



# https://smyl.es/how-to-fix-ubuntudebian-apt-get-404-not-found-package-repository-errors-saucy-raring-quantal-oneiric-natty/
# https://alselectro.wordpress.com/2014/03/30/ubuntu-13-10solution-to-broken-packages-problem/

sudo apt-get autoremove
sudo dpkg --configure -a 


# http://askubuntu.com/questions/124017/how-do-i-restore-the-default-repositories
sudo software-properties-gtk

sudo dpkg --configure -a --force-all



 skype-bin:i386 : Depends: libqtgui4:i386 (>= 4:4.8.0) but it is not going to be installed
                  Depends: libqtwebkit4:i386 (>= 2.2~2011week36) but it is not going to be installed
                  Recommends: sni-qt:i386 but it is not going to be installed
E: Unable to correct problems, you have held broken packages.



sudo dpkg --configure -a
sudo apt-get clean

sudo apt-get update -o Acquire::http::No-Cache=true

sudo apt-get upgrade
















### rvm | ruby | gems
```
# http://rvm.io/rvm/install
gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby
source /home/phoebe/.rvm/scripts/rvm
gem install zip mongo nokogiri bundler chef

```


### mongo
```
```

### mysql
```
sudo apt-get install mysql-server mysql-client
```

### virtualbox
```
sudo apt-get install virtualbox
sudo usermod -a -G vboxusers phoebe
```

### chromium | unstable-chromium
```
sudo apt-get install chromium-browser
# OR
# http://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-unstable
wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-unstable/google-chrome-unstable_40.0.2214.6-1_amd64.deb
dpkg -i ./google-chrome-unstable_40.0.2214.6-1_amd64.deb
google-chrome-unstable
```


### Brasero
```
sudo apt-get install cdrdao bchunk
toc2cue yourfile.toc yourfile.cue
bchunk yourfile.bin yourfile.cue yourfile.iso
```

3B-GVJSZJ-R18SDY-JOOB11

### 3D Printing - Makerbot
```
https://www.makerbot.com/support/new/Desktop/01_MakerBot_Desktop_Knowledge_Base/Using_MakerBot_Desktop/01-Getting_Started/How_to_Install_MakerBot_Desktop_for_Linux
lsb_release -c -s # trusty
sudo apt-add-repository 'deb http://downloads.makerbot.com/makerware/ubuntu trusty main'
wget http://downloads.makerbot.com/makerware/ubuntu/dev@makerbot.com.gpg.key
sudo apt-key add dev@makerbot.com.gpg.key
sudo apt-get update
sudo apt-get install makerware
makerware
```



# image tools
```
sudo apt-get install imagemagick
convert ./....

```




### image compression
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


### terminal prompt
PS1
```
```

### vim cheat sheet
```
UNDO       u
REDO       ctr+R
```

### vim color schemes




### RECORDING DESKTOP SW

# http://www.maartenbaert.be/simplescreenrecorder/
sudo add-apt-repository ppa:maarten-baert/simplescreenrecorder
sudo apt-get update
sudo apt-get install simplescreenrecorder
# if you want to record 32-bit OpenGL applications on a 64-bit system:
sudo apt-get install simplescreenrecorder-lib:i386

# something else
sudo apt-get install recordmydesktop 



# AUDIO STUFFS:
~$ gnome-control-center sound


sudo apt-get install xfce4-mixer    indicator-sound-gtk2

pulseaudio -k

sudo apt-get install paprefs 




xfce4-mixer






#### VHS STUFF
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



### run command periodically
```
watch -n 1   ls .
```


### git

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
*) hook all inputs (audio/video) into conversion device
*) hook in USB into slot, and mic into mic slot
*) to make sure linux is getting a video signal, run: ls /dev/video0
*) in terminal, run:  tvtime --g 640x360 
	*) example dimensions are:
	1.777: 640x360, 800x450, 880x495, 928x522
	1.333: 400x300, 480x360, 800x600, 1000x750, 1200x900
*) place tvtime screen in location on desktop to be recorded

*) in another terminal, run: xfce4-mixer
	*) we want to make sure audio is output thru the system
    *) maximize "Rear Mic" (or whatever plug you put the audio jack into)
    *) minimize "Rear Mic Boost" (to remove BG hissing)

*) in another terminal, run: simplescreenrecorder
    *) select window to record
    *) record the input audio channel [here: Built-in Audio Analog Stereo]
    *) select file to save to
    *) select video format
    *) select audio format
    *) show preview to make sure audio and video are as expected

*) DON'T TOUCH ANYTHING WHILE RECORDING

*) When done, pause recording, and save recording to disk

*) convert using ffmpeg in another terminal: (mess with settings)
	ffmpeg -i ./input.mkv -b 4000k -minrate 4000k -maxrate 4000k output.avi

*) edit in blender



EXAMPLE SETS:
	HOME MOVIES:
		1200x900, mp4+seperate+H.264+rate=24+fast+allow-skip, AAC+128




ffmpeg -i input.mkv output.avi


FFMPEG:
sudo add-apt-repository ppa:jon-severinsson/ffmpeg
sudo apt-get update
sudo apt-get install ffmpeg
sudo apt-get install frei0r-plugins

https://www.ffmpeg.org/ffmpeg.html

AVCONV
avconv -i input.mkv -codec copy output.mp4



MENCODER:
http://www.thelinuxguy.nl/how-tos/how-to-convert-mkv-movies-via-terminal/
mencoder nameofthemovie.mkv -vf scale=800:430 -ovc xvid -oac copy -xvidencopts bitrate=1200 -sid 1 -of avi -o nameofthemovie.avi





## References
```
http://www.binarytides.com/better-xubuntu-14-04/

```




gawddamn scroll wheel
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


sudo update-manager

# what is my version of xubuntu
cat /etc/*-release


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


