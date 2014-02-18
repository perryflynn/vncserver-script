This repo provides a collection of scripts to host a server with multiple vncserver sessions.

* ´vnc-functions.sh´ Provides functions for the other scripts.
* ´vnc-master-v2.sh´ Will executed as cron job and start the vncserver if not running or crashed.
* ´vnc-kill.sh´ Kill the vnc session.
* ´exampleuser/vncsettings.ini´ Placed in all user home folders. This ini provides settings for all vnc sessions.
* ´exampleuser/.vnc/xstartup´ Startscript, will called by vncserver process.

Features
--------

* Start vnc session automatically
* Restart crashed vnc sessions
* By-user log files in home folder
* The user can set the screen resolution of vnc
* A shortcut-script (´vnc-kill.sh´) to kill/restart the vnc session
* Start/Disable the autostart by create/delete the `vncautostartenabled´ file in users home folder

Installation
------------

* Place contol scripts in ´/home/´
* Setup vnc for the users (´~/.vnc/xstartup´, ´~/vncsettings.ini´, ...)
* Setup a cron as root for ´/home/vnc-master-v2.sh´
