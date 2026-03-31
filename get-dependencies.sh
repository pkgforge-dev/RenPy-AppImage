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
    sdl2_ttf                \
    uuid

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano ffmpeg-mini

# Comment this out if you need an AUR package
make-aur-package python-pygame-sdl2
make-aur-package python-sphinx_rtd_dark_mode

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
 	#make-aur-package renpy-git
# else
make-aur-package renpy
 	#PRE_BUILD_CMDS='sed -i "s|'\''/usr/lib/renpy/renpy.py'\''|renpy.py|" ./renpy-launcher.sh && sed -i "s|'\''1fc31125ce1a6be454e2e5995da1ba4860db6da687dbfffbca80a06f64aba43c'\''|'\''SKIP'\''|" ./PKGBUILD' make-aur-package renpy
# fi
mkdir -p ./AppDir/bin
mv -v /usr/lib/renpy/* ./AppDir/bin
