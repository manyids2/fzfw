#!/bin/bash

# PREVIEW

# --preview=COMMAND      Command to preview highlighted line ({})
# --preview-window=OPT   Preview window layout (default: right:50%)
#                        [up|down|left|right][,SIZE[%]]
#                        [,[no]wrap][,[no]cycle][,[no]follow][,[no]hidden]
#                        [,border-BORDER_OPT]
#                        [,+SCROLL[OFFSETS][/DENOM]][,~HEADER_LINES]
#                        [,default][,<SIZE_THRESHOLD(ALTERNATIVE_LAYOUT)]
# --preview-label=LABEL
# --preview-label-pos=N  Same as --border-label and --border-label-pos,
#                        but for preview window

REPO_DIR="../../fzf"
fzf \
  --preview "cat $REPO_DIR/{}"       \
  --preview-window=right   \
  --preview-label="   "   \
  --preview-label-pos=3    \
< fzf-repo-ls
