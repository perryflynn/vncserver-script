#!/bin/bash

USERHOME="$HOME"
IUSER="$(id -u -n)"
. /home/vnc-functions.sh

# Read custom resolutions from user config
while read RES; do

   # Id resolution exist, dont add
   EXIST="$(xrandr --current | grep "$RES" | wc -l)"
   if [ "$EXIST" -lt 1 ]; then

      # Width and height
      W="$(echo $RES | cut -d 'x' -f1 | sed 's/[^0-9]//g')"
      H="$(echo $RES | cut -d 'x' -f2 | sed 's/[^0-9]//g')"

      # Build add resolution command
      CCMD=$(cvt $W $H 60 | grep "Modeline" | sed 's/Modeline/xrandr --newmode/g' | sed 's/"//g')

$CCMD

      # Get name of new resolution
      NAME="$(xrandr --current | grep -E "[0-9]+x[0-9]+" | sed 's/^ *//g' | cut -d ' ' -f1 | tail -n 1)"

      # Get name of vnc display
      ONAME="$(xrandr --current | grep "connected" | cut -d ' ' -f1)"

      # Add resolution to vnc display
      ACMD="xrandr --addmode $ONAME $NAME"

$ACMD

   fi

done <<< "$(getprop "otherresolutions" | sed 's/,/\n/g')"

# Apply default resolution
resx="$(getprop "resolution_x" | sed 's/[^0-9]//g')"
resy="$(getprop "resolution_y" | sed 's/[^0-9]//g')"
xrandr -s ${resx}x${resy}