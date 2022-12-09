
# Vim Mode for macOS Finder
Keyboard-only control of macOS' Finder, inspired by vim/ranger. 

## Usage
![finder-vim-cheatsheet](/macos-finder-vim-mode.png).

> __Note__  
> Press `?` in Finder to show the following cheatsheet.


## Installations
- Requirements: [Karabiner Elements](https://karabiner-elements.pqrs.org/)

```bash
open "karabiner://karabiner/assets/complex_modifications/import?url=https://raw.githubusercontent.com/chrisgrieser/.config/main/karabiner/assets/finder-vim.json"
curl -sL "https://raw.githubusercontent.com/chrisgrieser/.config/main/visualized-keyboard-layout/macos-finder-vim-mode.png" -o "$HOME/.config/karabiner/assets/macos-finder-vim-mode.png"
```

## Caveats
- To be used in `List View` only. 
- if you have a complex modification affecting the capslock key, it has to come __after__ Finder Vim Controls in Karabiner's priority list.

### Alfred



Finder-Vim-Mode factors in the usage of Spotlight or Alfred with `cmd+space`. However, if you use another key combination with Alfred (for example for the clipboard or the Universal action), you have to use one of the following methods:

1. (Easier) Temporarily pause Finder-Vim-Mode via `⌫ backspace`, use Alfred, and as soon as you press either `capslock`, `escape`, or `return`, Finder-Vim-Mode will be active again.
2. Permanently disable Finder-Vim-Mode for the respective Alfred Commands by downloading the [Finder-Vim-Mode-Addon](karabiner/assets/finder-vim-addons.json) and customizing it keys. The `from` and `to` keys need to be the same (except for the extra intermediary `mandatory`), the first example uses modifier keys, the second only a single keystroke.
