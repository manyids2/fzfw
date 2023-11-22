#!/bin/bash

# SEARCH

# -x, --extended         Extended-search mode
#                         (enabled by default; +x or --no-extended to disable)
# -e, --exact            Enable Exact-match
# -i                     Case-insensitive match (default: smart-case match)
# +i                     Case-sensitive match
# --scheme=SCHEME        Scoring scheme [default|path|history]
# --literal              Do not normalize latin script letters before matching
# -n, --nth=N[,..]       Comma-separated list of field index expressions
#                         for limiting search scope. Each can be a non-zero
#                         integer or a range expression ([BEGIN]..[END]).
# --with-nth=N[,..]      Transform the presentation of each line using
#                         field index expressions
# -d, --delimiter=STR    Field delimiter regex (default: AWK-style)
# +s, --no-sort          Do not sort the result
# --tac                  Reverse the order of the input
# --disabled             Do not perform search
# --tiebreak=CRI[,..]    Comma-separated list of sort criteria to apply
#                         when the scores are tied [length|chunk|begin|end|index]
#                         (default: length)

fzf \
  --extended              \
  --exact                 \
  -i                      \
  --scheme=default        \
  --literal               \
  --delimiter='/'         \
  --no-sort               \
  --tac                   \
  --disabled              \
  --tiebreak=length,index \
  < fzf-repo-ls
