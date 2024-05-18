#!/bin/bash
# Script to install the Vicon DataStream SDK required for the motion capture system

# Check if the script is running as root
if [[ $EUID -ne 0 ]]; then
    echo "This script requires root privileges!" 1>&2
    exit 1
fi

# Define the URL and file names
SDK_URL="https://github.com/atarbabgei/miscellaneous/raw/main/motion-capture/vicon/DataStreamSDK_1.12.0.zip"
SDK_ZIP="DataStreamSDK_1.12.0.zip"
SDK_DIR="DataStreamSDK_1.12.0"
LIB_DIR="/usr/lib"

# Function to install a library
install_lib() {
    local lib_file=$1
    if cp "$SDK_DIR/$lib_file" "$LIB_DIR"; then
        echo "$lib_file installed."
    else
        echo "Failed to copy $lib_file" 1>&2
        exit 1
    fi
}

# Download the Vicon DataStream SDK
if wget "$SDK_URL" -O "$SDK_ZIP"; then
    echo "Downloaded $SDK_ZIP successfully."
else
    echo "Failed to download $SDK_URL" 1>&2
    exit 1
fi

# Unzip the downloaded file
if unzip "$SDK_ZIP"; then
    echo "Unzipped $SDK_ZIP successfully."
else
    echo "Failed to unzip $SDK_ZIP" 1>&2
    exit 1
fi

# Remove the downloaded zip file
rm "$SDK_ZIP"

# Check if the unzipped directory exists
if [[ -d "$SDK_DIR" ]]; then
    # Change the directory to the unzipped folder
    cd "$SDK_DIR" || { echo "Failed to change directory to $SDK_DIR" 1>&2; exit 1; }
else
    echo "Directory $SDK_DIR does not exist after unzipping" 1>&2
    exit 1
fi

# Install Vicon DataStream SDK shared libraries
echo "Installing shared libraries, please wait..."
install_lib "libViconDataStreamSDK_CPP.so"
install_lib "libboost_chrono-mt-x64.so.1.75.0"
install_lib "libboost_thread-mt-x64.so.1.75.0"
install_lib "libboost_timer-mt-x64.so.1.75.0"
install_lib "libboost_system-mt-x64.so.1.75.0"

# Set permissions for the installed libraries
if chmod 0755 "$LIB_DIR"/libViconDataStreamSDK_CPP.so \
               "$LIB_DIR"/libboost_chrono-mt-x64.so.1.75.0 \
               "$LIB_DIR"/libboost_thread-mt-x64.so.1.75.0 \
               "$LIB_DIR"/libboost_timer-mt-x64.so.1.75.0 \
               "$LIB_DIR"/libboost_system-mt-x64.so.1.75.0; then
    echo "Permissions set successfully."
else
    echo "Failed to set permissions" 1>&2
    exit 1
fi

# Update the library cache
if ldconfig; then
    echo "Library cache updated successfully."
else
    echo "Failed to update library cache" 1>&2
    exit 1
fi

echo "Installation finished."
