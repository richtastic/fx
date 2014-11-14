# FX
## xubuntu: live is pain

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

## vim
```
sudo apt-get install vim
```

### blender
```
# http://www.blender.org/download/
wget http://ftp.nluug.nl/pub/graphics/blender/release/Blender2.72/blender-2.72b-linux-glibc211-x86_64.tar.bz2
tar -vxf ./blender-2.72b-linux-glibc211-x86_64.tar.bz2 
mv ./blender-2.72b-linux-glibc211-x86_64 /opt/
ln -s /opt/blender-2.72b-linux-glibc211-x86_64/blender /opt/blender
```

### sublime
```
# http://www.sublimetext.com/3
wget http://c758482.r82.cf2.rackcdn.com/sublime_text_3_build_3065_x64.tar.bz2
tar -vxf ./sublime_text_3_build_3065_x64.tar.bz2
mv sublime_text_3/ /opt/
ln -s /opt/sublime_text_3/sublime_text /opt/sublime
```

### git
```
sudo apt-get install git gitk
```


### octave
```
sudo apt-get install octave
```

### rvm | ruby | gems


### mongo

### mysql

### virtualbox
```
sudo apt-get install virtualbox
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



### terminal / shell color themes



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


```

