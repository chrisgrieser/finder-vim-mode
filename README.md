# Vim Mode for Finder
Feature-rich mouseless control of macOS Finder, inspired by vim/ranger. 

![](https://img.shields.io/github/last-commit/chrisgrieser/finder-vim-mode?style=plastic)

![Finder Vim cheatsheet](./finder-vim-mode-cheatsheet.png)

## Usage Examples
- `rl`: Duplicate selected file and open the copy.
- `axw`: Select all files, move them to the other window, close current window.
- `.f.d.`: Show hidden files, select first dotfile, delete it, hide hidden files.
- `AM`: Select files (but not folders), create a new directory, move selected files into that directory, and start renaming the directory (enters insert mode).
- `azmhp`:  Select all files and folders, zip them, (wait for zipping to finish,) and move the archive one directory up

## Table of Contents
<!--toc:start-->
- [Usage](#usage)
- [Installation](#installation)
- [Updates](#updates)
- [Caveats](#caveats)
- [Why not use a Terminal file manager?](#why-not-use-a-terminal-file-manager)
- [Build](#build)
- [Alfred and Raycast users](#alfred-and-raycast-users)
- [Credits](#credits)
<!--toc:end-->

## Usage
- Only works in Finder's `List View`.
- __`:help`__ Press `?` in Finder to display the cheatsheet above.
- __Move__: `m` marks the current selection as "to be moved." The next paste-operation `p` moves the files. A move can be aborted via `esc`.
- __Cross-move__: If you have *exactly* two Finder windows open, `x` moves the selection to the other window, and `X` copies the selection to the other window.
- __Context-menu__: Can be opened with `q` and navigated via `hjkl`. Use `esc` or press `q` again to close the context-menu.
- __Find mode__ triggered via `f`, works similar to `f` in vim, expecting another character afterward. For example, `fh` jumps to the next file, which starts with the letter `h`.
- __Toggle `-bkp` suffix__: Add suffix `-bkp` to the file. If it already has such a suffix, remove it. Useful for debugging as well.
- __`Tab`__ goes to the next file in alphabetical order, *even when the view is not sorted alphabetically.* (This is actually a built-in feature of Finder, but probably worth pointing out since barely anyone knows about it.)
- __Open in GitHub__: If the file is in a git repo, `Ctrl+g` opens the file at GitHub and also copies the URL to the clipboard.
- ℹ️ Consult the [vim help](https://vimhelp.org/) for the ex-commands you are not familiar with.

> __Note__  
> You can "deactivate" the macOS Desktop via `defaults write com.apple.finder CreateDesktop false`. This way, `<BS>` (going to the next finder window) never focuses the desktop.

## Installation
1. Run this in your terminal:

    ```bash
    brew install karabiner-elements # Install Karabiner (if not already installed)
    open "karabiner://karabiner/assets/complex_modifications/import?url=https://raw.githubusercontent.com/chrisgrieser/finder-vim-mode/main/finder-vim.json"
    curl -sL "https://raw.githubusercontent.com/chrisgrieser/finder-vim-mode/main/finder-vim-cheatsheet.png" -o "$HOME/.config/karabiner/assets/finder-vim-mode-cheatsheet.png"
    ```

2. Activate the plugin: `Import` → `Enable`
3. __Karabiner users:__ If you already use Karabiner and have another modification affecting the `Capslock` key, that modification must come *after* the __Finder Vim Mode__ in the list of modifications.
4. __Alfred and Raycast users:__ [Some additional setup may be needed.](#alfred-and-raycast-users).

## Updates
Unfortunately, Karabiner has no mechanism for auto-updating plugins. Therefore, you have to install updates manually by re-running the code above. You can check for the last commit date to see whether there has been an update:

![](https://img.shields.io/github/last-commit/chrisgrieser/finder-vim-mode?style=plastic)

## Caveats
Since Karabiner plugins are only hotkey re-mappings without proper scripting mechanism, this plugin has some limitations:
- Only __List view__ is supported. 
- __Pressing `return` in a prompt window__, for example when replacing a
file, mistakenly puts you in Insert Mode. (Unfortunately, Karabiner is not able to detect whether the front window is a regular Finder window or a prompt). The workaround is to either press `esc` to go back to Normal Mode, or to use `tab` and `space` to select the correct action in the confirmation window.
- If you __use the mouse to click buttons__, you can end up in the wrong mode. In that case, you can press `esc` to get back to Normal Mode. (Or, you know, just do not use the mouse. You're a vim user, after all.)
- File selection dialogues from other apps (for example, to upload a file in the browser) are not supported.
- Unfortunately, it is __not possible to have a `vimrc` or to let the user configure the keybindings__ themselves in any way, at least not with a Karabiner plugin. If you want to rebind keys, you have to change the respective key manually in the JSON file.

## Why not use a Terminal file manager?
Other than a nicer appearance, a GUI does have a few advantages:
- Many apps have some way sort of `Reveal current file in Finder` feature, which is quite handy but does not work with a TUI file manager.
- With a GUI, you get a separate app in various places like the dock, the built-in app switcher `cmd+tab`, or other app switchers (for example, `rcmd`). With a TUI, you'd have to switch to your Terminal, and then switch to your file manager, requiring basically an extra step.
- Image and file content previews as icons are not available with a TUI-file manager.
- Finder actually has quite a lot hidden features, which this plugin is utilizing.
- A GUI allows you to have multiple windows open and work with them (for example, the `x` command in this plugin), while you cannot easily move files between two terminal windows.
- A bunch of automation apps for mac work with "if app x is frontmost" conditions. With a TUI, those apps only see that your terminal is frontmost, but are mostly not able to tell what TUI is running inside the terminal.
- Cloud services (iCloud, Google Drive, Dropbox, etc.) indicate the file sync status of a file in Finder.

## Build
Karabiner plugins are essentially hotkey configurations in form of a JSON file. Since the amount of configurations for this plugin is rather large, the resulting JSON file has more than 6000 lines. To make that manageable, this plugin is written in YAML, where features such as anchors and aliases reduces the lines of code to only ~1000 lines.

If you want to fork this plugin, it is recommended to work with the YAML file and "compile" it to the [JSON required by Karabiner](https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/). You can do so with [yq](https://github.com/mikefarah/yq). (Note that the `explode()` is required to resolve the anchors and aliases.)

```bash
yq -o=json 'explode(.)' finder-vim.yaml > finder-vim.json
```

## Alfred and Raycast users
Finder-Vim-Mode factors in the usage of Spotlight, Alfred, or Raycast via `cmd+space`. However, if you use another key combination, for example for Alfred's clipboard history or Universal Action, you have to use one of the following methods:

1. Permanently disable Finder-Vim-Mode for the respective Alfred or Raycast Commands by downloading the [Finder-Vim-Alfred-Addon](./finder-vim-alfred-addon.json) and customizing its keys. The `from` and `to` keys need to be the same (except for the extra intermediary `mandatory`).
2. (Recommended) In [Alfred's Appearance Options](https://www.alfredapp.com/help/appearance/#options), set the `Focusing` behavior to `Compatibility Mode`. Note that this can affect triggers of the kind "if X is the frontmost app, then…" used by certain macOS automation apps.

## Credits
The cheatsheet has been created with <http://www.keyboard-layout-editor.com/>.

<!-- vale Google.FirstPerson = NO -->
__About Me__  
In my day job, I am a sociologist studying the social mechanisms underlying the digital economy. For my PhD project, I investigate the governance of the app economy and how software ecosystems manage the tension between innovation and compatibility. If you are interested in this subject, feel free to get in touch.

__Profiles__  
- [Academic Website](https://chris-grieser.de/)
- [ResearchGate](https://www.researchgate.net/profile/Christopher-Grieser)
- [Discord](https://discordapp.com/users/462774483044794368/)
- [GitHub](https://github.com/chrisgrieser/)
- [Twitter](https://twitter.com/pseudo_meta)
- [Mastodon](https://pkm.social/@pseudometa)
- [LinkedIn](https://www.linkedin.com/in/christopher-grieser-ba693b17a/)

__Buy me a Coffee__  
<br>
<a href='https://ko-fi.com/Y8Y86SQ91' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://cdn.ko-fi.com/cdn/kofi1.png?v=3' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>
