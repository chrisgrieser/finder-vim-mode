.PHONY: build, cheatsheet, all, transfer
#───────────────────────────────────────────────────────────────────────────────

update: | transfer build

# transfer stuff from my local device
transfer:
	cp "$$HOME/.config/karabiner/assets/finder-vim-mode-cheatsheet.json" . ; \
	cp "$$HOME/.config/karabiner/assets/finder-vim-mode-cheatsheet.png" . ; \
	cp "$$HOME/.config/karabiner/assets/complex_modifications/4 finder-vim-mode.yaml" ./finder-vim.yaml

# Build Karabiner modification, requires `yq`
build:
	yq -o=json 'explode(.)' finder-vim.yaml > finder-vim.json

cheatsheet:
	open 'http://www.keyboard-layout-editor.com/'
