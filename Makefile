.PHONY: build, cheatsheet, update, transfer
#───────────────────────────────────────────────────────────────────────────────

update: | transfer build

# transfer stuff from local device
transfer:
	local_mode_name="4 finder-vim-mode.yaml" ; \
	cp -v "$$HOME/.config/karabiner/assets/complex_modifications/$$local_mode_name" ./finder-vim.yaml
	cp -v "$$HOME/.config/karabiner/assets/finder-vim-mode-cheatsheet.json" . 
	cp -v "$$HOME/.config/karabiner/assets/finder-vim-mode-cheatsheet.png" .

# Build Karabiner modification, requires `yq`
build:
	yq --output-format=json 'explode(.)' finder-vim.yaml > finder-vim.json && echo "✅ Compiled Karabiner modification JSON."

cheatsheet:
	open 'http://www.keyboard-layout-editor.com/'
	open -R "$$HOME/.config/karabiner/assets/finder-vim-mode-cheatsheet.json"
