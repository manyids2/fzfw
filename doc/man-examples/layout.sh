#!/bin/bash

# LAYOUT

# --height=[~]HEIGHT[%]  Display fzf window below the cursor with the given
#                        height instead of using fullscreen.
#                        If prefixed with '~', fzf will determine the height
#                        according to the input size.
# --min-height=HEIGHT    Minimum height when --height is given in percent
#                        (default: 10)
# --layout=LAYOUT        Choose layout: [default|reverse|reverse-list]
# --border[=STYLE]       Draw border around the finder
#                        [rounded|sharp|horizontal|vertical|
#                         top|bottom|left|right|none] (default: rounded)
# --border-label=LABEL   Label to print on the border
# --border-label-pos=COL Position of the border label
#                        [POSITIVE_INTEGER: columns from left|
#                         NEGATIVE_INTEGER: columns from right][:bottom]
#                        (default: 0 or center)
# --margin=MARGIN        Screen margin (TRBL | TB,RL | T,RL,B | T,R,B,L)
# --padding=PADDING      Padding inside border (TRBL | TB,RL | T,RL,B | T,R,B,L)
# --info=STYLE           Finder info style [default|hidden|inline|inline:SEPARATOR]
# --separator=STR        String to form horizontal separator on info line
# --no-separator         Hide info line separator
# --scrollbar[=CHAR]     Scrollbar character
# --no-scrollbar         Hide scrollbar
# --prompt=STR           Input prompt (default: '> ')
# --pointer=STR          Pointer to the current line (default: '>')
# --marker=STR           Multi-select marker (default: '>')
# --header=STR           String to print as header
# --header-lines=N       The first N lines of the input are treated as header
# --header-first         Print header before the prompt line
# --ellipsis=STR         Ellipsis to show when line is truncated (default: '..')

fzf \
  --multi                \
  --height=~80%          \
  --min-height=5         \
  --layout=reverse       \
  --border=rounded       \
  --border-label="   "  \
  --border-label-pos=3   \
  --margin=0             \
  --padding=0            \
  --info=inline          \
  --no-separator         \
  --scrollbar=▐          \
  --prompt=🐱            \
  --pointer=🐷           \
  --marker=🐶            \
  --header-lines=0       \
  --header-first         \
  --ellipsis=           \
  < fzf-repo-ls
