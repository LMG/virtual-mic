MixMic -- Mix your mics
-------------
This program allows one to create virtual microphones mixing inputs from
different sources using pulseaudio.

To build and install this program:

./autogen.sh --prefix=/home/your_username/.local
make install

-------------
Running the first line above creates the following files:

aclocal.m4
autom4te.cache
config.log
config.status
configure
mixmic.desktop
install-sh
missing
Makefile.in
Makefile

Running "make install", installs the application to 

/home/your_username/.local/bin

and installs the mixmic.desktop file to 

/home/your_username/.local/share/applications

You can now run the application by typing "mixmic" in the Overview.

----------------
To uninstall, type:

make uninstall

----------------
To create a tarball type:

make distcheck

This will create mixmic-1.0.tar.xz
