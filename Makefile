.PHONY: build, cheatsheet
#───────────────────────────────────────────────────────────────────────────────

build:
	yq -o=json 'explode(.)' finder-vim.yaml > finder-vim.json

cheatsheet:
	open 'http://www.keyboard-layout-editor.com/'
