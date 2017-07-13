#!/bin/sh

# Firefox Developer Edition install
# No need to download this script, just run it on your terminal:
#  $  curl -L git.io/firefoxdev | sh
# When you need to update Firefox Developer Edition, run this script again.
# downloaded from https://gist.github.com/grenade/3b3c5b17586881d01142#file-update_firefox_developer_edition-sh

START_CMD="ffd"
INSTALLATION_DIR="/opt/firefox"

# Detect the architecture
if [ "$(uname -m)" = "x86_64" ]; then
  ARCHITECTURE="x86_64"
else
  ARCHITECTURE="i686"
fi

# Detect the locale
LOCALE=$(echo $LANG | sed -r 's/([a-z]{2})_([A-Z]{2}).*/\1-\2/')

# Detect the latest build version
BUILD=$(echo $(curl https://download-installer.cdn.mozilla.net/pub/firefox/nightly/latest-mozilla-aurora-l10n/linux-$ARCHITECTURE/xpi/) | sed -r "s/.*firefox-([0-9\.a]+)\.$LOCALE\.langpack\.xpi.*/\1/")

URL="https://download-installer.cdn.mozilla.net/pub/firefox/nightly/latest-mozilla-aurora-l10n/firefox-{$BUILD}.{$LOCALE}.linux-{$ARCHITECTURE}.tar.bz2"

# Download the tarball, unpack and install
curl -o $HOME/$START_CMD.tar.bz2 $URL
if tar -xf $HOME/$START_CMD.tar.bz2 --directory=$HOME; then
  # Create an application launcher file based on the regular firefox launcher
  cat /usr/share/applications/firefox.desktop | sed -r 's/Name=Firefox/Name=Firefox Developer Edition/g' | sed -r 's/Exec=firefox %u/Exec=ffd %u/g' | sed -r "s/Icon=firefox/Icon=$(echo $INSTALLATION_DIR | sed -r 's/\//\\\//g')\/browser\/chrome\/icons\/default\/default48.png/g" > $HOME/firefox/firefox.desktop
  # Remove the installation folder and the symlink, they might already exist
  sudo rm -rf $INSTALLATION_DIR /bin/$START_CMD
  sudo mv $HOME/firefox $INSTALLATION_DIR
  sudo ln -s $INSTALLATION_DIR/firefox /bin/$START_CMD
fi
rm $HOME/$START_CMD.tar.bz2

# Add to applications list
sudo ln -s $INSTALLATION_DIR/firefox.desktop /usr/share/applications/$START_CMD.desktop

echo ""
echo "Firefox Developer Edition installed successfully!"
