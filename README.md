# Vim Mode for macOS Finder
Keyboard-only control of the Finder.app, inspired by vim/ranger. 

![finder-vim-cheatsheet](./finder-vim-cheatsheet.png)

<!--toc:start-->
- [Usage](#usage)
- [Installations](#installations)
- [Updates](#updates)
- [Caveats](#caveats)
- [Why not use a Terminal file manager?](#why-not-use-a-terminal-file-manager)
- [Build](#build)
- [For Alfred users](#for-alfred-users)
- [Credits](#credits)
<!--toc:end-->

## Usage
- Only works in Finder's `List View`.
- Press `?` in Finder to show the cheatsheet above.
- `m` marks the current selection as "to be moved." The next paste-operation `p` moves the files.
- If you have *exactly* two Finder windows open, `x` moves the selection to the other window.
- The context-menu can be opened with `q` and navigated via `hjkl`. Use `esc` or press `q` again to close the context-menu.
- The find mode triggered via `f` works similarly to `f` in vim, expecting another letter (or digit) afterwards. `fh`, for example, would jump to the next file which starts with the letter `h`, and `f6` jumps to the next file that starts with `6`.
- Tip: You can also "deactivate" the macOS Desktop via `defaults write com.apple.finder CreateDesktop false`. This way, `b` never focuses the desktop.
- Consult the [vim help](https://vimhelp.org/) for the Ex commands you are not familiar with.

## Installations
- Install [Karabiner Elements](https://karabiner-elements.pqrs.org/).
- Run this in your terminal:

```bash
# Install Karabiner (if not already installed)
brew install karabiner-elements

# Install Finder-Vim-Mode plugin for Karabiner
open "karabiner://karabiner/assets/complex_modifications/import?url=https://github.com/chrisgrieser/finder-vim-mode/releases/latest/download/finder-vim.json"
curl -sL "https://raw.githubusercontent.com/chrisgrieser/finder-vim-mode/main/finder-vim-cheatsheet.png" -o "$HOME/.config/karabiner/assets/finder-vim-mode-cheatsheet.png"
```

## Updates
Unfortunately, Karabiner has no mechanism for auto-updating its plugins. Therefore, you have to install updates manually by re-running the code above. You can watch the releases of this repo to be notified when there are updates.

## Caveats
Since Karabiner plugins are nothing more than JSON files, this plugin has some limitations:
- Only List view is supported. The desktop is not supported.
- File selection dialogues from other apps (e.g., to upload a file in the browser) are not supported.
- This has only been tested on the German QWERTZ keyboard layout and the standard US-QWERTY layout. There are probably some bugs with other layouts, if you stumble upon one, please open a bug report.
- If you use the mouse to click buttons or confirm things, you might end up in the wrong mode. In that case, Press `esc` to get back to Normal Mode. You can also temporarily disable Finder Vim Mode via `backspace`.
- Unfortunately, it is not possible to have a vimrc or to let the user configure the keybindings themselves in any way, at least not with a Karabiner plugin. If you want to rebind keys, you will have to change the respective key manually in the JSON file.
- If you have a other karabiner modification affecting the capslock key, it should come __after__ Finder Vim Controls in Karabiner's priority list to avoid conflicts.

## Why not use a Terminal file manager?
Other than a nicer appearance, a GUI does have a few advantages like better operating-system-integration. [I listed a few advantages of a GUI file manager over a TUI file manager at the reddit thread.](https://www.reddit.com/r/vim/comments/zkwk5x/comment/j07b7ak/?utm_source=share&utm_medium=web2x&context=3)

## Build
Karabiner plugins are essentially hotkey configurations in a JSON file. Since the amount of configurations for this plugin is rather large, the resulting JSON file has more than 6000 lines. To make that manageable, this plugin is written in YAML, where features such as anchors and aliases greatly reduces the lines of code to only ~800 lines.

If you want to modify or fork this plugin, I recommend working with the YAML file and "compile" it to [the JSON required by Karabiner](https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/). You can do so via [yq](https://github.com/mikefarah/yq):

```bash
yq -o=json 'explode(.)' finder-vim.yaml > finder-vim.json
```

## For Alfred users
Finder-Vim-Mode factors in the usage of Spotlight or Alfred with `cmd+space`. However, if you use another key combination with Alfred, for example for the clipboard or the Universal action, you have to use one of the following methods:

1. Temporarily pause Finder-Vim-Mode via `⌫ backspace`, and use Alfred. As soon as you press either `capslock`, `escape`, or `return`, Finder-Vim-Mode is active again.
2. (Recommended) Permanently disable Finder-Vim-Mode for the respective Alfred Commands by downloading the [Finder-Vim-Alfred-Addon](./finder-vim-alfred-addon.json) and customizing its keys. The `from` and `to` keys need to be the same (except for the extra intermediary `mandatory`).
3. Enable `Compatibility Mode` in the Alfred Appearance options. Note that this might break some Alfred workflows, which rely on this option being off.

<!-- vale Google.FirstPerson = NO -->
## Credits
Cheatsheet created with <http://www.keyboard-layout-editor.com/>

__About me__  
In my day job, I am a sociologist studying the social mechanisms underlying the digital economy. For my PhD project, I investigate the governance of the app economy and how software ecosystems manage the tension between innovation and compatibility. If you are interested in this subject, feel free to get in touch.
