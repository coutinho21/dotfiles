
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


# keymaps
setxkbmap us -option caps:escape,ctrl:ralt_rctrl

# detach the Control modifier
xmodmap -e "remove control = Control_R"

# map the physical Right Control key to Backspace
xmodmap -e "keycode 105 = BackSpace"

# re-attach the Control modifier
xmodmap -e "add control = Control_R"

# map ISO <> key (left of Left Shift) to Shift
xmodmap -e "keycode 94 = Shift_L NoSymbol Shift_L"
xmodmap -e "add shift = Shift_L"

# map physical Backspace to backslash/pipe
xmodmap -e "keycode 22 = backslash bar backslash bar"


# merge high dpi
xrdb -merge ~/.Xresources

# keyboard rate
xset r rate 200 45

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


