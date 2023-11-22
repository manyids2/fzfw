# fzf-extras

## transforms

- cd to selected parent directory

```bash
local dirs=()
local parent_dir

get_parent_dirs() {
  if [[ -d "$1" ]]; then dirs+=("$1"); else return; fi
  if [[ "$1" == '/' ]]; then
    for _dir in "${dirs[@]}"; do echo "$_dir"; done
  else
    get_parent_dirs "$(dirname "$1")"
  fi
}
```

- cd into the directory from stack
- `dirs` stores stack created with `pushd .` and `popd`
```bash
dirs \
  | sed 's#\s#\n#g' \
  | uniq \
  | sed "s#^~#$HOME#" \
```

## lists

- cd to selected directory
  `find "${1:-.}" -path '*/\.*' -prune -o -type d -print 2> /dev/null`
- including hidden directories
  `find "${1:-.}" -type d 2> /dev/null`
- cd to selected parent directory
  `get_parent_dirs "$(realpath "${1:-$PWD}")"`
- dir from stack
  `dirs`
- frecency directory
  `fasd -dl`
- files listed in another file
  TODO: wtf does `"${files/\~/$HOME}"` mean?
  ```bash
  # v - open files in ~/file
  v() {
    local files
    files="$(
      grep '^>' "$HOME/file" \
        | cut -c3- \
        | while read -r line; do
            [[ -f "${line/\~/$HOME}" ]] && echo "$line" # wtf does this do?
          done \
        | fzf -m -0 -1 -q "$*"
    )"
    "${EDITOR:-nvim}" "${files/\~/$HOME}"
  }
  ```

## previews

- `bat --color=always --plain --line-range :$FZF_PREVIEW_LINES {}`
- `head -n $FZF_PREVIEW_LINES {} | pygmentize -g`
- `head -n $FZF_PREVIEW_LINES {}`
- `tree -C {} | head -n $FZF_PREVIEW_LINES `

## bindings

## style

## output

- cd into directory from output
  `cd "$dir" || return`
- cd into directory of file
  `cd "$(dirname "$file")" || return`
- open files in editor, with given default
  `"${EDITOR:-nvim}" "${files[@]}"`
- using expect
  ```bash
  # Get files, and keys pressed
  out=(
    "$(
        fzf-tmux \
          --query="$1" \
          --exit-0 \
          --expect=ctrl-o,ctrl-e
    )"
  )

  # Parse
  key="$(head -1 <<< "${out[@]}")"
  file="$(head -2 <<< "${out[@]}" | tail -1)" || return

  # conditional
  if [[ "$key" == ctrl-o ]]; then
    "${OPENER:-xdg-open}" "$file"
  else
    "${EDITOR:-nvim}" "$file"
  fi
  ```
  

## state machine
