#!/bin/bash

echo "<openbox_pipe_menu>"

# Read all available resolutions from xrandr
while read LINE; do

        # Resolution name
        RES="$(echo $LINE | cut -d ' ' -f1)"

        # Resolution display name
        CRES="$(echo $RES | sed 's/_.*//g')"

        # Active resolution?
        ACT="$(echo $LINE | grep '*' | wc -l)"

        ACTTEXT=""
        if [ "$ACT" == "1" ]; then
                ACTTEXT=" (current)"
        fi

        # Build opebox xml menu item
        echo "<item label=\"$CRES$ACTTEXT\">"
        echo "<action name=\"Execute\"><execute>xrandr -s $RES</execute></action>"
        echo "</item>"

done <<< "$(xrandr --current | grep -E "^\s+[0-9]+x[0-9]+")"

echo "</openbox_pipe_menu>"