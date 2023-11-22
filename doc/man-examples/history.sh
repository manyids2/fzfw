#!/bin/bash

# HISTORY

# --history=FILE         History file
# --history-size=N       Maximum number of history entries (default: 1000)

fzf \
  --history=/tmp/history  \
  --history-size=10       \
< fzf-repo-ls
