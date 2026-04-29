
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


