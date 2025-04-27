set quiet := true

update: transfer build

# transfer stuff from local device
transfer:
    local_mode_name="4 finder-vim-mode.yaml" ; \
    cp -v "$HOME/.config/karabiner/assets/complex_modifications/$local_mode_name" ./finder-vim.yaml
    cp -v "$HOME/.config/karabiner/assets/finder-vim-mode/cheatsheet.json" ./extras
    cp -v "$HOME/.config/karabiner/assets/finder-vim-mode/cheatsheet.png" ./extras
    cp -v "$HOME/.config/karabiner/assets/finder-vim-mode/notificator" ./extras

# Build Karabiner modification, requires `yq`
build:
    yq --output-format=json 'explode(.)' finder-vim.yaml > finder-vim.json && \
    	echo "✅ Compiled Karabiner modification JSON."

# RECREATE THE CHEATSHEET
# INFO the cheatsheet should not be downloaded as PNG, since the PNG is quite
# low quality. To get higher quality, it is better to make a screenshot instead.

cheatsheet:
    open 'http://www.keyboard-layout-editor.com/'
    open -R "$HOME/.config/karabiner/assets/finder-vim-mode/cheatsheet.png"
