# Vim Mode for macOS Finder
Keyboard-only control for Finder, inspired by vim/ranger. 

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
- *move*: `m` marks the current selection as "to be moved." The next paste-operation `p` moves the files.
- *cross-move*: If you have *exactly* two Finder windows open, `x` moves the selection to the other window.
- *context-menu*: can be opened with `q` and navigated via `hjkl`. Use `esc` or press `q` again to close the context-menu.
- *Find mode* triggered via `f`, works similarly to `f` in vim, expecting another character afterwards. For example, `fh` jumps to the next file which starts with the letter `h`.
- *`-bkp` Toggle*: Add suffix `-bkp` to the file. If it already has such a suffix, remove it. Useful for debugging, too.
- *GitHub*: `ctrl+g` opens the file at GitHub and also copies the URL to the clipboard.
- Tip: You can "deactivate" the macOS Desktop via `defaults write com.apple.finder CreateDesktop false`. This way, `<BS>` (going to the next finder window) never focuses the desktop.
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
Unfortunately, Karabiner has no mechanism for auto-updating its plugins. Therefore, you have to install updates manually by re-running the code above. 

## Caveats
Since Karabiner plugins are only hotkey-remappings without proper scripting mechanism, this plugin has some limitations:
- Only List view is supported. The desktop is not supported.
- File selection dialogues from other apps (e.g., to upload a file in the browser) are not supported.
- This has only been tested on the German QWERTZ keyboard layout and the standard US-QWERTY layout. There are probably some bugs with other layouts, if you stumble upon one, please open a bug report.
- If you use the mouse to click buttons, you might end up in the wrong mode. In that case, Press `esc` to get back to Normal Mode. You can also temporarily disable Finder Vim Mode via `backspace`.
- Karabiner cannot detect whether you are focusing a regular finder window or a confirmation window (for example to replace a file). If you encounter one of these, you can end up in the wrong mode afterwards. If this is the case, just press `esc` to get back to Normal Mode.
- Unfortunately, it is not possible to have a vimrc or to let the user configure the keybindings themselves in any way, at least not with a Karabiner plugin. If you want to rebind keys, you have to change the respective key manually in the JSON file.
- If you have a other Karabiner modification affecting the capslock key, it should come __after__ Finder Vim Controls in Karabiner's priority list to avoid conflicts.

## Why not use a Terminal file manager?
Other than a nicer appearance, a GUI does have a few advantages like better operating-system-integration:
- Many apps have some way sort of "reveal current file in Finder" feature, which is quite handy but does not work with a TUI file manager.
- With a GUI, you get a separate app in various places like the dock, the built-in app switcher (cmd+tab) or other app switchers (e.g., rcmd). With a TUI, you'd have to switch to your Terminal, and then switch to your file manager via tmux etc, requiring basically an extra step
- image previews and file content previews in an icon are not available with a TUI-file manager
- for some cases, drag-n-drop is still useful, which to my knowledge also does not work with a TUI
- Finder actually has some nice features like tags, which you can only get with some extra plugin for a TUI-file manager as far as I know
- a GUI allows me to have multiple windows open and work with them (e.g., the x command in my plugin), while you cannot move files between two terminal windows which ranger open?
- a bunch of automation apps for mac work with "if app x is frontmost" conditionals. with a TUI, those apps only see that your terminal is frontmost, but are mostly not able to tell what TUI is running inside the terminal.
- cloud services (iCloud, Google Drive, Dropbox, etc.) indicate the file sync status of a file in Finder. As far as I know, no TUI is able to display such kind of information.

## Build
Karabiner plugins are essentially hotkey configurations in a JSON file. Since the amount of configurations for this plugin is rather large, the resulting JSON file has more than 6000 lines. To make that manageable, this plugin is written in YAML, where features such as anchors and aliases reduces the lines of code to only ~1000 lines.

If you want to fork this plugin, I recommend working with the YAML file and "compile" it to the [JSON required by Karabiner](https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/). You can do so via [yq](https://github.com/mikefarah/yq):

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
