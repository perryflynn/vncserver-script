#!/bin/bash

function getprop() {
   local PROP=$1
   local PROPFILE="$USERHOME/vncsettings.ini"

   if [ -f "$PROPFILE" ]; then
      cat "$PROPFILE" | grep -v -E "^#" | grep -E "^${PROP}=" | cut -d '=' -f2 | head -n 1 | sed -e 's/^ *//g' -e 's/ *$//g' | sed 's/([^a-zA-Z0-9_\.,])/\\$1/g'
   fi
}

function startserver() {
   local port="$(getprop "tcp_port" | sed 's/[^0-9]//g')"

   if [ "$port" == "" ]; then
      return 2
   else
      # Perform start and get display name
      CMD="vncserver -rfbport $port -interface 127.0.0.1 -localhost -geometry 1024x768"
      echolog "VNC startup command: $CMD"
      OUT=$(su $IUSER -c "$CMD" 2>&1)
      DNAME=$(echo -e "$OUT" | grep "desktop is" | awk -F" " '{print $(NF)}')
      echolog "Detected Displayname: $DNAME"

      # Check for successfull start
      if [ -f "$USERHOME/.vnc/${DNAME}.pid" ]; then
         cp "$USERHOME/.vnc/${DNAME}.pid" "$USERHOME/vncserver.pid"
         return 0
      else
         return 1
      fi
  fi
}

function echolog() {
   local msg=$1
   local logfile="$USERHOME/vncstartlog.txt"
   if [ -f "$logfile" ]; then
      local temp=$(mktemp)
      tail -n 100 "$logfile" > $temp
      mv "$temp" "$logfile"
   fi
   echo -e "[$(date)]  $msg" | tee -a "$logfile"
   if [ "$(id -u)" == "0" ]; then
      chown $IUSER:$IUSER "$logfile"
   fi
   chmod a+r "$logfile"
}