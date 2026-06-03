
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


# merge high dpi
xrdb -merge ~/.Xresources

# keyboard rate
xset r rate 200 45

# start the status bar for dwm
slstatus &

# stop screen dimming
xset s off -dpms

exec dwm
```


