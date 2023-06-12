# Style

## All options

```bash
git ls-files             \
  | fzf                  \
  --multi                \
  --height=~80%          \
  --min-height=5         \
  --margin=0             \
  --padding=0            \
  --layout=reverse       \
  --border=rounded       \
  --border-label="   "  \
  --border-label-pos=3   \
  --scrollbar=▐          \
  --no-separator         \
  --pointer=🐷           \
  --marker=🐶            \
  --prompt=🐱            \
  --ellipsis=           \
  --info=inline          \
  --header-lines=0       \
  --header-first
```

### Layout

```bash
git ls-files        \
  | fzf             \
  --height=~80%     \
  --min-height=5    \
  --margin=0        \
  --padding=0       \
  --layout=reverse
```

### Spacing

```bash
git ls-files  \
  | fzf       \
  --margin=0  \
  --padding=0
```

### Border

```bash
git ls-files             \
  | fzf                  \
  --border=rounded       \
  --border-label="   "  \
  --border-label-pos=3   \
  --scrollbar=▐          \
  --no-separator
```

### Symbols

```bash
git ls-files   \
  | fzf        \
  --pointer=🐷 \
  --marker=🐶  \
  --prompt=🐱  \
  --ellipsis=
```

### Headers

```bash
git ls-files       \
  | fzf            \
  --info=inline    \
  --header-lines=0 \
  --header-first
```
