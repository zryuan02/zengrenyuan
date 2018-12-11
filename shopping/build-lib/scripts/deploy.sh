#!/bin/bash


##########################################
#
# This deploy script is usues for remote-deploy
# After the pacakge has been copy/upload to hybris dir
# this script will trigger to to unzip -> build -> Initialize
# 
#############################################

CUSTOM_EXT_DIR=./bin/custom
CONF_DIR=./config
ARCHIVE_DIR=./archive
WORK_DIR=`pwd`

function exec_update {
	cd bin/platform
	. ./setantenv.sh
	echo "Hybris Server Stopped."
	echo "Building Hybris ........."
	ant clean customize all	
	echo "Hybris built completed"
	echo "Initializing Hybris........"
	ant initialize
	echo "Hybris initialized."
}


function stop_hybris {
	# Could change as service start /stop
	cd bin/platform
	echo "Stopping Hybris Server....."
	#./hybrisserver.sh stop
	/etc/init.d/hybris stop
	echo "Hybris Server Stopped."
}

function start_hybris {
	# Could change as service start /stop
	cd bin/platform
	echo "Starting Hybris Server....."
	/etc/init.d/hybris start
	echo "Hybris Server Started."
}

#stop_hybris

cd $WORK_DIR

# Backup Config and Extenstion Folder
echo "Prepare to move existing config and extension to archive directory"
if [ -d  "$ARCHIVE_DIR" ]; then
	rm -rf "$ARCHIVE_DIR"
fi

mkdir "$ARCHIVE_DIR"
mv ./config "$ARCHIVE_DIR"/config
mv ./bin/custom "$ARCHIVE_DIR"/custom

echo "Backup has been made on $ARCHIVE_DIR"


echo "Clean Up custom extension directory on $CUSTOM_EXT_DIR"
if [ -d  "$CUSTOM_EXT_DIR" ]; then
	rm -rf "$CUSTOM_EXT_DIR"
fi
mkdir "$CUSTOM_EXT_DIR"

echo "Clean Up config directory on $CONF_DIR"
if [ -d  "$CONF_DIR" ]; then
	rm -rf "$CONF_DIR"
fi
mkdir "$CONF_DIR"

# Unzip Custome extension and Config
unzip css_config.zip -d ./config
unzip css_custom.zip -d ./bin/custom

# exec_update

# start_hybris