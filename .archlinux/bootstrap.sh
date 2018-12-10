#!/bin/sh

# End the script on any errors
set -e

# Change the working directory to this one
cd "$(dirname "$0")"

# Get administrative privileges
sudo -v

# Keep pinging sudo until this script finishes
# Source: https://gist.github.com/cowboy/3118588
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install PKGBUILDs
make package=tari-core
make package=bspwm-round-corners-git
make package=color-scripts
make package=xeventbind

# Install yay
make aur package=yay

# Install aur packages with yay
yay -S rtv
yay -S polybar
yay -S shotgun
yay -S ranger-git

# Additional settings
make fontconfig
make yarnconfig

# Revoke privileges
sudo -K

# Install dotfiles
make -C ..

# Change the color scheme to a sane default
wal --theme base16-tomorrow-night

# Run vim for the first time (i.e. install plugins and exit)
nvim