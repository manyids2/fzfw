#!/bin/bash

# SCRIPTING

# -q, --query=STR        Start the finder with the given query
# -1, --select-1         Automatically select the only match
# -0, --exit-0           Exit immediately when there's no match
# -f, --filter=STR       Filter mode. Do not start interactive finder.
# --print-query          Print query as the first line
# --expect=KEYS          Comma-separated list of keys to complete fzf
# --read0                Read input delimited by ASCII NUL characters
# --print0               Print output delimited by ASCII NUL characters
# --sync                 Synchronous search for multi-staged filtering
# --listen=HTTP_PORT     Start HTTP server to receive actions (POST /)
# --version              Display version information and exit

fzf \
--exact             \
--query="m"         \
--select-1          \
--exit-0            \
--filter="man"      \
--print-query       \
--sync              \
< fzf-repo-ls

