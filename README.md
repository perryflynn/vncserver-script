This repo provides a collection of scripts to host a server with multiple vncserver sessions.

* `vnc-functions.sh` Provides functions for the other scripts.
* `vnc-master-v2.sh` Will executed as cron job and start the vncserver if not running or crashed.
* `vnc-kill.sh` Kill the vnc session.
* `vnc-resmenu.sh` Pipemenu for openbox to change resolution at runtime.
* `vnc-add-custom-resolutions.sh` Called by xstartup. Will add custom resolutions to xrandr.
* `exampleuser/vncsettings.ini` Placed in all user home folders. This ini provides settings for all vnc sessions.
* `exampleuser/.vnc/xstartup` Startscript, will called by vncserver process.
* `exampleuser/.config/openbox/menu.xml` Example for openbox menu integration.

Features
--------

* Start vnc session automatically
* Restart crashed vnc sessions
* By-user log files in home folder
* The user can set the screen resolution of vnc
* Add custom resolutions to xrandr on startup
* A shortcut-script (`vnc-kill.sh`) to kill/restart the vnc session
* Start/Disable the autostart by create/delete the `vncautostartenabled` file in users home folder
* Pipemenu for openbox to change resolution at runtime

Installation
------------

* Place contol scripts in `/home/`
* Setup vnc for the users (`~/.vnc/xstartup`, `~/vncsettings.ini`, ...)
* Setup a cron as root for `/home/vnc-master-v2.sh`

Screenshots
-----------

![Resolution Menu](/screen-resolutionmenu.png "Resolution Menu")

Server Components:
* Guacamole web remote desktop
* Nginx web proxy
* TightVNC
* OpenBox
* lxpanel
* conky

![The Desktop](/screen-desktop.png "The Desktop")
