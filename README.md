# prior-art

An academic study of [fzf](https://github.com/junegunn/fzf).

From [Related projects](https://github.com/junegunn/fzf/wiki/Related-projects)

## Examples

man-examples
├──  fzf-repo-ls # example file with 126 lines
├──  interface.sh
├──  search.sh
├──  layout.sh
├──  preview.sh
├──  history.sh
├──  environment.sh
├──  scripting.sh
└──  display.sh

## Structure

- L: lists ( `ls`, `git branch -a`, etc. )
- T: transforms ( `cut`, `sed`, etc. )
- P: previews ( `cat`, `bat`, `diff`, etc. )
- B: bindings
- S: style
- O: output ( `cd {}`, `git checkout {}`, etc. )
- M: state machine

## prior-art

Aggregating uses of fzf in example repos.

From each repo, extract the above structure, where possible.
Update model where impossible.

### Shell

* [ ] [fzf-extras](https://github.com/atweiden/fzf-extras)
* [ ] [fzf-scripts](https://github.com/DanielFGray/fzf-scripts)
* [ ] [fzfuncs](https://github.com/3hhh/fzfuncs)
* [ ] [fzf-bibtex](https://github.com/msprev/fzf-bibtex)
* [ ] [cite](https://github.com/seifferth/cite)
* [ ] [dotbare](https://github.com/kazhala/dotbare)
* [ ] [sad](https://github.com/ms-jpq/sad)
* [ ] [fuzzy-fs](https://github.com/SleepyBag/fuzzy-fs)
* [ ] [zle-fzf](https://github.com/SleepyBag/zle-fzf)
* [ ] [Fzf-bash-ide-resource](https://github.com/rayiik/Fzf-bash-ide-resource)
* [ ] [fzf-bluetooth-connect](https://github.com/Rasukarusan/fzf-bluetooth-connect)
* [ ] [interactively](https://github.com/bigH/interactively)
* [ ] [auto-sized-fzf](https://github.com/bigH/auto-sized-fzf)
* [ ] [fzg](https://github.com/krakozaure/fzg)

### Bookmarks

* [ ] [fzf-marks](https://github.com/urbainvaes/fzf-marks)
* [ ] [formarks](https://github.com/wfxr/formarks)
* [ ] [zfm](https://github.com/pabloariasal/zfm)
* [ ] [dirp](https://github.com/avindra/dirp)
* [ ] [fzf-obc](https://github.com/rockandska/fzf-obc)
* [ ] [fzf-tab-completion](https://github.com/lincheney/fzf-tab-completion)
* [ ] [fzf-tab](https://github.com/Aloxaf/fzf-tab)
* [ ] [fzf-zsh-completions](https://github.com/chitoku-k/fzf-zsh-completions)
* [ ] [clifm](https://github.com/leo-arch/clifm)

### Git

* [ ] [git-fuzzy](https://github.com/bigH/git-fuzzy)
* [ ] [forgit](https://github.com/wfxr/forgit)
* [ ] [fizzygit](https://github.com/EfforiaKnight/fizzygit)
* [ ] [git-ignore](https://github.com/laggardkernel/git-ignore)
* [ ] [omgit](https://gitlab.com/Energy1011/omgit)
* [ ] [ugit](https://github.com/Bhupesh-V/ugit)
* [ ] [gh-f](https://github.com/gennaro-tedesco/gh-f)

## Goals

implement git-forgit using only config and no code

Supplementary goals:

- define modules for each type of option
- use them as mixins
- define keymaps -> global, local
- create 'tabs'
