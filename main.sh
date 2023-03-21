#! /bin/bash
set -e
# Add dependent repositories
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports
# Clone Upstream
sudo apt install -y libsass1 sassc
git clone https://github.com/vinceliuice/Orchis-kde
cd ./Orchis-kde
patch -Np1 -i ../patches/kde.patch
./install.sh
cp -rvf ./orchis-theme-kde ../debian/
cd ../
git clone https://github.com/vinceliuice/Orchis-theme
cd ./Orchis-theme
mkdir -p ./orchis-theme-gtk/usr/share/themes
./install.sh -d ./orchis-theme-gtk/usr/share/themes -t all  --shell 42 --tweaks submenu
cp -rvf ./orchis-theme-gtk ../debian/
cd ../
mkdir -p orchis-theme
cp -rvf ./debian ./orchis-theme/
cd  orchis-theme

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
