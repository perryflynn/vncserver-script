#!/bin/bash

if [ -d "/home/.vnc-master.lock" ]; then
   exit 1;
fi

touch /home/.vnc-master.lock


USERHOME=""
IUSER=""

# Include functions
. /home/vnc-functions.sh

# Walk user homes
for USERHOME in /home/*; do

   # Extract username from home folder path
   IUSER=$(echo $USERHOME | cut -d '/' -f3)

   # If directory and contains vncautostartenabled
   if [ -d "$USERHOME" ] && [ -f "$USERHOME/vncautostartenabled" ]; then
      echo Check status of $USERHOME

      # Check vncserver process
      ISRUNNING=0
      if [ -f "$USERHOME/vncserver.pid" ]; then
         PID=$(cat $USERHOME/vncserver.pid)
         if [ "$(ps -p $PID | wc -l)" -gt 1 ]; then

            # All ok, process running
            ISRUNNING=1

         else

            # Process was started, but now dead
            ISRUNNING=0
            rm "$USERHOME/vncserver.pid"
            echolog "VNC Server was killed!"

         fi
      else
         # Process not running
         ISRUNNING=0
      fi

      # Perform start
      if [ "$ISRUNNING" == "0" ] && [ -f "$USERHOME/vncsettings.ini" ]; then

         echolog "Perform server start"
         echolog "Resolution: $(getprop "resolution_x")x$(getprop "resolution_y")"
         echolog "TCP Port: $(getprop "tcp_port")"

         startserver
         STARTRESULT=$?

         if [ "$STARTRESULT" == "0" ]; then
            echolog "VNC Server start successfull"
         elif [ "$STARTRESULT" == "1" ]; then
            echolog "VNC Server start failed"
         elif [ "$STARTRESULT" == "2" ]; then
            echolog "VNC Server start failed: Config error"
         else
            echolog "VNC Server start result unknown"
         fi

      # Must start but no starter available
      elif [ "$ISRUNNING" == "0" ]; then
         echolog "Error: VNC is not running but no configuration ini available"

      # Already running
      else
         echo "VNC server is already started"

      fi

   fi
done

rm /home/.vnc-master.lock
