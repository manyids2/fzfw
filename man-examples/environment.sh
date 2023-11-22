#!/bin/bash

# ENVIRONMENT VARIABLES

# FZF_DEFAULT_COMMAND    Default command to use when input is tty
# FZF_DEFAULT_OPTS       Default options
#                        (e.g. '--layout=reverse --inline-info')

export FZF_DEFAULT_COMMAND="ls"
export FZF_DEFAULT_OPTS="--layout=reverse"
fzf

export FZF_DEFAULT_COMMAND="exa --icons"
export FZF_DEFAULT_OPTS="--exact"
fzf
