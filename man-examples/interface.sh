#!/bin/bash

# INTERFACE

# -m, --multi[=MAX]      Enable multi-select with tab/shift-tab
# --no-mouse             Disable mouse
# --bind=KEYBINDS        Custom key bindings. Refer to the man page.
# --cycle                Enable cyclic scroll
# --keep-right           Keep the right end of the line visible on overflow
# --scroll-off=LINES     Number of screen lines to keep above or below when
#                        scrolling to the top or to the bottom (default: 0)
# --no-hscroll           Disable horizontal scroll
# --hscroll-off=COLS     Number of screen columns to keep to the right of the
#                        highlighted substring (default: 10)
# --filepath-word        Make word-wise movements respect path separators
# --jump-labels=CHARS    Label characters for jump and jump-accept

fzf \
  --multi=5           \
  --no-mouse          \
  --cycle             \
  --keep-right        \
  --scroll-off=5      \
  --hscroll-off=10    \
  --filepath-word     \
< fzf-repo-ls
