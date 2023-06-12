.PHONY: install

define ANNOUNCE_INSTALL
    Copied
  cp **/*.sh ./ ${HOME}/.local/fzf
endef
export ANNOUNCE_INSTALL

install:
	find ./man-examples/ -type f -name "*.sh" | xargs -I % cp % ${HOME}/.local/fzf
	@echo "$$ANNOUNCE_INSTALL"
	@echo "$$(tree ${HOME}/.local/fzf)"

define ANNOUNCE_DELETE
    Delete?
  rm ${HOME}/.local/fzf/*.sh
endef
export ANNOUNCE_DELETE

clean:
	@echo "$$ANNOUNCE_DELETE"
	@echo -n "Are you sure? [y/N] " && read ans && [ $${ans:-N} = y ]
	rm ${HOME}/.local/fzf/*.sh
