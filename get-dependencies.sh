#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm     \
    assimp                  \
    ftgl                    \
    libdecor                \
    python-ecdsa            \
    python-legacy-cgi       \
    python-setuptools-scm   \
    python-sphinx_rtd_theme \
    sdl2_gfx                \
    sdl2_image              \
    sdl2_mixer              \
    sdl2_ttf

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ffmpeg-mini

# Comment this out if you need an AUR package
make-aur-package python-pygame-sdl2
make-aur-package python-sphinx_rtd_dark_mode
make-aur-package uuid

# If the application needs to be manually built that has to be done down here
if [ "${DEVEL_RELEASE-}" = 1 ]; then
	package=renpy-git
else
	package=renpy
fi
make-aur-package "$package"
pacman -Q "$package" | awk '{print $2; exit}' > ~/version

mkdir -p ./AppDir/bin
mv -v /usr/lib/renpy/* ./AppDir/bin
