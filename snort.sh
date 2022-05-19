# This script deploys snort 3 on ubuntu according the official guide given on
# https://snort-org-site.s3.amazonaws.com/production/document_files/files/000/000/211/original/Snort3.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIXACIED2SPMSC7GA%2F20200213%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200213T042310Z&X-Amz-Expires=172800&X-Amz-SignedHeaders=host&X-Amz-Signature=e871bb91fa3aa573ad8e425f0bcd641f8bd0f729562f42667d5b454fe9ad17a0

cat << EOF
Making sure that your system is up-to-date
==========================================
EOF

sudo apt-get update && sudo apt-get dist-upgrade -y

cat << EOF
Please ensure that timezone is correctly configured . . .
EOF

sudo dpkg-reconfigure tzdata

cat << EOF
Creating required directories
EOF
mkdir ~/snort_src
cd ~/snort_src

cat << EOF
Installing Snort 3 Prerequisites
================================
EOF

sudo apt-get install -y build-essential autotools-dev libdumbnet-dev libluajit-5.1-dev libpcap-dev zlib1g-dev pkg-config libhwloc-dev cmake

cat << EOF
Intalling Snort 3 optional but highly recommended libraries
===========================================================
EOF

sudo apt-get install -y liblzma-dev openssl libssl-dev cpputest libsqlite3-dev uuid-dev

cat << EOF
Installing softwares required for source control
================================================
EOF

sudo apt-get install -y libtool git autoconf

cat << EOF
Installing Snort DAQ Prerequisites
==================================
EOF

sudo apt-get install -y bison flex

cat << EOF
Installing libraries for Snort inline mode using NFQ
====================================================
EOF

sudo apt-get install -y libnetfilter-queue-dev libmnl-dev

cat << EOF
Downloading and installing safec
================================
EOF

cd ~/snort_src
wget https://github.com/rurban/safeclib/releases/download/v04062019/libsafec-04062019.0-ga99a05.tar.gz
tar -xzvf libsafec-04062019.0-ga99a05.tar.gz
cd libsafec-04062019.0-ga99a05/
./configure
make
sudo make install

cat << EOF
Installing latest PRCE
======================
EOF

cd ~/snort_src/
wget https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.gz
tar -xzvf pcre-8.43.tar.gz
cd pcre-8.43
./configure
make
sudo make install

cat << EOF
Download and install gperools 2.7
==================================
EOF

cd ~/snort_src
wget https://github.com/gperftools/gperftools/releases/download/gperftools-2.7/gperftools-2.7.tar.gz
tar xzvf gperftools-2.7.tar.gz
cd gperftools-2.7
./configure
make
sudo make install

cat << EOF
Installing Regal and Boost headers for HyperScan
================================================
EOF

# Installing Regal
cd ~/snort_src
wget http://www.colm.net/files/ragel/ragel-6.10.tar.gz
tar -xzvf ragel-6.10.tar.gz
cd ragel-6.10
./configure
make
sudo make install

# Installing Boost
cd ~/snort_src
wget https://dl.bintray.com/boostorg/release/1.71.0/source/boost_1_71_0.tar.gz
tar -xvzf boost_1_71_0.tar.gz

cat << EOF
Install Hyperscan 5.2 from source
=================================
EOF

cd ~/snort_src
wget https://github.com/intel/hyperscan/archive/v5.2.0.tar.gz
tar -xvzf v5.2.0.tar.gz

mkdir ~/snort_src/hyperscan-5.2.0-build
cd hyperscan-5.2.0-build/

cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DBOOST_ROOT=~/snort_src/boost_1_71_0/ ../hyperscan-5.2.0

make
sudo make install

cd ~/snort_src/hyperscan-5.2.0-build/
./bin/unit-hyperscan

cat << EOF
Installing (Optional) Flatbuffers Library
=========================================
EOF

cd ~/snort_src
wget https://github.com/google/flatbuffers/archive/v1.11.0.tar.gz -O flatbuffers-v1.11.0.tar.gz
tar -xzvf flatbuffers-v1.11.0.tar.gz
mkdir flatbuffers-build
cd flatbuffers-build
cmake ../flatbuffers-1.11.0
make
sudo make install

cat << EOF
Download and install DAQ from Snort Website
===========================================
EOF

cd ~/snort_src
git clone https://github.com/snort3/libdaq.git
cd libdaq
./bootstrap
./configure
make
sudo make install

cat << EOF
Updating Shared libraries
=========================
EOF

sudo ldconfig

cat << EOF
Ready to donwload and install snort...
Downloading Snort 3
===================
EOF

cd ~/snort_src
git clone git://github.com/snortadmin/snort3.git
cd Snort3

cat << EOF
Installing Snort3 with default settings
=======================================
EOF

./configure_cmake.sh --prefix=/usr/local --enable-tcmalloc
cd build
make
sudo make install

cat << EOF
Checking if snort is properly installed
=======================================
EOF

/usr/local/bin/snort -V

cat << EOF
Initial Snort Setup completed
=============================
Please refer to https://snort-org-site.s3.amazonaws.com/production/document_files/files/000/000/211/original/Snort3.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIXACIED2SPMSC7GA%2F20200213%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20200213T042310Z&X-Amz-Expires=172800&X-Amz-SignedHeaders=host&X-Amz-Signature=e871bb91fa3aa573ad8e425f0bcd641f8bd0f729562f42667d5b454fe9ad17a0 
Section: Configuring Environmental Variables for next steps of the setup
EOF

cat << EOF
Meow
EOF
