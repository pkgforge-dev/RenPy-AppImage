#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    assimp              \
    ftgl                \
    libdecor            \
    python-ecdsa        \
    python-legacy-cgi   \
    python-pygame-sdl2  \
    sdl2_gfx            \
    sdl2_image          \
    sdl2_mixer          \
    sdl2_ttf

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ffmpeg-mini

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
 	#make-aur-package renpy-git
# else
 	make-aur-package renpy
# fi
