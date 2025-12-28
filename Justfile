set quiet := true

local_file_name := "3 finder-vim-mode.yaml"

#-------------------------------------------------------------------------------

update: transfer build

# transfer stuff from local device
transfer:
    #!/usr/bin/env zsh
    set -e # exit if any of those files do not exist
    asset_folder="$HOME/.config/karabiner/assets"
    cp -v "$asset_folder/complex_modifications/{{ local_file_name }}" ./finder-vim.yaml
    cp -v "$asset_folder/finder-vim-mode/cheatsheet.json" ./extras
    cp -v "$asset_folder/finder-vim-mode/cheatsheet.png" ./extras
    cp -v "$asset_folder/finder-vim-mode/notificator" ./extras

# Build Karabiner modification, requires `yq`
build:
    yq --output-format=json 'explode(.)' finder-vim.yaml > finder-vim.json && \
      echo "✅ Compiled Karabiner modification JSON."

# RECREATE THE CHEATSHEET
# INFO the cheatsheet should not be downloaded as PNG, since the PNG is quite
# low quality. To get higher quality, it is better to make a screenshot instead.

cheatsheet:
    open 'http://www.keyboard-layout-editor.com/'
    open -R "$HOME/.config/karabiner/assets/finder-vim-mode/cheatsheet.json"
