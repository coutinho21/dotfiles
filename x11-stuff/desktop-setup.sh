#!/bin/sh

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

# keyboard rate
xset r rate 200 45


