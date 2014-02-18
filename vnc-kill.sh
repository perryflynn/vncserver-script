#!/bin/bash

USERHOME="$HOME"
IUSER="$(id -un)"

# Include functions
. /home/vnc-functions.sh

PROPDISP="$(getprop "display")"

if [ "$PROPDISP" == "" ]; then
   echolog "Could not read display number from config"
else
   echolog "Trying to kill the VNC session"
   echolog "Requested by $(id -un)"
   echolog "Output: $(vncserver -kill $PROPDISP 2>&1)"
fi
