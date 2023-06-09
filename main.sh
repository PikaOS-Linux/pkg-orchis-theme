#! /bin/bash
set -e

# Clone Upstream
sudo apt install -y libsass1 sassc
mkdir -p orchis-theme
git clone https://github.com/vinceliuice/Orchis-kde
cd ./Orchis-kde
patch -Np1 -i ../patches/kde.patch
./install.sh
cp -rvf ./orchis-theme-kde ../orchis-theme/
mkdir -p ../orchis-theme/sddm-theme-orchis/usr/share/sddm/themes/
cp -rvf sddm/Orchis ../orchis-theme/sddm-theme-orchis/usr/share/sddm/themes/
cd ../
#git clone https://github.com/vinceliuice/Orchis-theme
cd ./Orchis-theme
#mkdir -p ./orchis-theme-gtk/usr/share/themes
#./install.sh -d ./orchis-theme-gtk/usr/share/themes -t all  --shell 42 --tweaks submenu
cp -rvf ./orchis-theme-gtk ../orchis-theme/
cd ../
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
