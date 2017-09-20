#The actual runnable program is set to the SCRIPTS primitive.
# Will be installed in bindir (/usr/local/bin?)
bin_SCRIPTS = src/mixmic \
  src/bindApp.sh \
  src/connectToMic.sh  \
  src/createMic.sh  \
  src/listApps.sh 
#List of files to be distributed
EXTRA_DIST =  \
	$(bin_SCRIPTS) 

#The desktop files
desktopdir = $(datadir)/applications
desktop_DATA = \
	mixmic.desktop
