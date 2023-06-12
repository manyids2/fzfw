#!/bin/bash

# DISPLAY

# --ansi                 Enable processing of ANSI color codes
# --tabstop=SPACES       Number of spaces for a tab character (default: 8)
# --color=COLSPEC        Base scheme (dark|light|16|bw) and/or custom colors
# --no-bold              Do not use bold text

fzf \
  --ansi              \
  --tabstop=8         \
  --color=dark        \
< fzf-repo-ls
