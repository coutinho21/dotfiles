
### turn on a second monitor with different resolution

2880x1800 & 1920x1080

```
xrandr --output DP-3 --auto --scale 1.5x1.5 --pos 0x0 --output eDP-1 --auto --pos 0x1620
```


### ~/.Xresources

```
Xft.dpi: 192
```


### ~/.xinitrc

Append to the file:

```

# env vars for ghidra
export _JAVA_AWT_WM_NONREPARENTING=1

~/desktop-setup.sh

# merge high dpi
xrdb -merge ~/.Xresources

# start the status bar for dwm
slstatus &

# stop screen dimming
xset s off -dpms


# Wrap PipeWire and DWM inside a single, unified D-Bus session
exec dbus-run-session sh -c "
    pipewire &
    wireplumber &
    pipewire-pulse &
    exec dwm
"

exec dwm
```


