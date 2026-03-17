#!/bin/bash
sleep 3

if xrandr | grep -q "^DSI-1 connected"; then
    
    xrandr --output DSI-1 --rotate left

    sleep 1
    xinput set-prop 'Goodix Capacitive TouchScreen' 'Coordinate Transformation Matrix' 0 -1 1 1 0 0 0 0 1

else
    exit 0
fi