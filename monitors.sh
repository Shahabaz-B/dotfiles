#!/bin/bash
EXTERNAL_OUTPUT="DP1-1"
EXTERNAL_OUTPUT2="DP1-2"
INTERNAL_OUTPUT="eDP1"

# if we don't have a file, start at zero
if [ ! -f "/tmp/monitor_mode.dat" ] ; then
  monitor_mode="all"

# otherwise read the value from the file
else
  monitor_mode=`cat /tmp/monitor_mode.dat`
fi

if [ $monitor_mode = "all" ]; then
        monitor_mode="EXTERNAL"
        xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT2 --auto --output $EXTERNAL_OUTPUT --auto --primary --left-of $EXTERNAL_OUTPUT2
elif [ $monitor_mode = "EXTERNAL" ]; then
        monitor_mode="INTERNAL"
        xrandr --output $INTERNAL_OUTPUT --auto --primary --output $EXTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT2 --off
elif [ $monitor_mode = "INTERNAL" ]; then
        monitor_mode="CLONES"
        xrandr --output $INTERNAL_OUTPUT --auto --primary --output $EXTERNAL_OUTPUT --auto --same-as $INTERNAL_OUTPUT
else
        monitor_mode="all"
        xrandr --output $INTERNAL_OUTPUT --auto --primary --output $EXTERNAL_OUTPUT2 --auto --left-of $INTERNAL_OUTPUT --output $EXTERNAL_OUTPUT --auto --left-of $EXTERNAL_OUTPUT2
fi
echo "${monitor_mode}" > /tmp/monitor_mode.dat
