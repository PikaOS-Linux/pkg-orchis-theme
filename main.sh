# Add dependent repositories
wget -q -O - https://ppa.pika-os.com/key.gpg | sudo apt-key add -
add-apt-repository https://ppa.pika-os.com
add-apt-repository ppa:pikaos/pika
add-apt-repository ppa:kubuntu-ppa/backports
# Clone Upstream
git clone https://github.com/vinceliuice/Orchis-kde
cd ./Orchis-kde
patch -Np1 -i ../patches/kde.patch
./install.sh
cd ../
git clone https://github.com/vinceliuice/Orchis-theme
cd ./Orchis-theme
./install.sh -d ../debian/orchis-theme-gtk/usr/share/themes
cd ../
mkdir -p orchis-theme
cp -rvf ./debian ./orchis-theme/
cd  orchis-theme

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
