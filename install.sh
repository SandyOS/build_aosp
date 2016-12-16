#Installing requirements
sudo echo "Installing requirements"
echo "Adding OpenJDK and Jochenkemnade to repositories for install"
nohup sudo add-apt-repository -y  ppa:openjdk-r/ppa
nohup sudo add-apt-repository -y  ppa:jochenkemnade/openjdk-8
echo "added OpenJDK and Jochenkemnade successfully"
echo "Installing openjdk-7 and openjdk-8"
nohup sudo apt-get update
nohup sudo apt-get -y install openjdk-7-jdk
nohup sudo apt-get -y install openjdk-8-jdk
nohup sudo apt-get -y install openjdk-7-jre
nohup sudo apt-get -y install openjdk-8-jre

#for ubuntu 
nohup sudo apt-get -y -f install
sudo update-alternatives --config java
sudo update-alternatives --config javac
nohup sudo  apt-get -y install git-core gnupg flex bison gperf build-essential \
  zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
  lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
  libgl1-mesa-dev libxml2-utils xsltproc unzip

nohup wget -S -O - http://source.android.com/source/51-android.rules | sed "s/<username>/$USER/" | sudo tee >/dev/null /etc/udev/rules.d/51-android.rules; sudo udevadm control --reload-rules
nohup sudo apt-get -y install git

reset

export a=`pwd`/aosp
export bin=$a/bin
export m=$a/M
export n=$a/N
export out=$a/out
export OUT_DIR_COMMON_BASE=$out

mkdir $a
mkdir $m
mkdir $n
mkdir $out

mkdir $bin

curl https://storage.googleapis.com/git-repo-downloads/repo > $a/bin/repo
chmod a+x $a/bin/repo
PATH=$a/bin:$PATH


#Configuring git for AOSP
read -p "Name: "$name
read -p "Email: "$email

git config --global user.name $name
git config --global user.email $email


echo "Initializing repo for Marshmallow"
cd $m
repo init -u https://android.googlesource.com/platform/manifest -b android-6.0.1_r69
echo "Now before syncing, I shall warn that this may take a few hours to days depending on your internet"
echo "Please do not cancel this script or turn off your PC/Laptop/Tablet/Phone"
repo sync



echo "Initializing repo for No Cat (Nougat. Get it? No Cat?)"
cd $n

repo init -u https://android.googlesource.com/platform/manifest -b android-7.1.0_r7
echo "Now before syncing, I shall warn that this may take a few hours to days depending on your internet connection"
echo "Please do not cancel this script or turn off your PC/Laptop/Tablet/Phone" 
repo sync



echo "We are done syncing! Have fun building!"
