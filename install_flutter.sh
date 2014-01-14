#!/bin/sh

sudo apt install xz-utils unzip openjdk-8-jdk

cd /tmp/

# Install Flutter
# https://flutter.dev/docs/get-started/install/linux
if [ ! -f flutter_linux_2.5.3-stable.tar.xz ]; then
    wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.5.3-stable.tar.xz
fi
tar xf flutter_linux_2.5.3-stable.tar.xz
mv flutter_linux_2.5.3-stable $HOME/flutter

# Install Android SDK
# https://developer.android.com/studio/index.html#downloads
wget https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip
unzip commandlinetools-linux-7583922_latest.zip
mkdir -p $HOME/Android/Sdk/cmdline-tools
mv commandlinetools-linux-7583922_latest $HOME/Android/Sdk/cmdline-tools/latest
$HOME/Android/Sdk/cmdline-tools/latest/bin/sdkmanager 'build-tools;31.0.0' 'platform-tools' 'platforms;android-31' 

# Check result
flutter doctor
