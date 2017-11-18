#!/bin/bash
# Fitxer: desktop-generator.sh
# Autor: Víctor Molina Ferreira (victor.molinaf@gmail.com)
# Data: 17/11/2017
# Versión: 1.0

#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.

# Cogemos los datos del archivo .conf
source $( dirname "${BASH_SOURCE[0]}" )/user.conf

function addDesktop {
    full_route=$desktop_route$NAME".desktop"
    desktop_route=$(echo ${full_route// /_} | tr '[:upper:]' '[:lower:]')
    echo "[Desktop Entry]" > $desktop_route
    echo "Encoding=UTF-8" >> $desktop_route
    echo "Exec="$FILE >> $desktop_route
    echo "Icon="$IMAGE >> $desktop_route
    echo "Type=Application" >> $desktop_route
    echo "Terminal=false" >> $desktop_route
    echo "Name="$NAME >> $desktop_route
}

# Nos conectamos como root
ls /root >/dev/null 2>&1
if [ $? != 0 ]
then
	echo "Permission denied"
	exit 1
fi

NAME=`zenity --entry \
--title="Add desktop" \
--text="Name of application:" \
--entry-text "PhpStorm"`

FILE=`zenity --file-selection --title="Select the application"`

case $? in
    1)
        echo "No file selected.";;
    -1)
        echo "An unexpected error has occurred.";;
esac

IMAGE=`zenity --file-selection --title="Select image"`

case $? in
    1)
        echo "No file selected.";;
    -1)
        echo "An unexpected error has occurred.";;
esac

addDesktop
