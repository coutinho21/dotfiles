#!/bin/sh

# keymaps
setxkbmap us -option caps:escape,ctrl:ralt_rctrl

# detach the Control modifier
xmodmap -e "remove control = Control_R"

# map the physical Right Control key to Backspace
xmodmap -e "keycode 105 = BackSpace"

# re-attach the Control modifier
xmodmap -e "add control = Control_R"



# keyboard rate
xset r rate 200 45



