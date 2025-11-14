# Vim Mode for Finder
Feature-rich control of macOS Finder without the mouse, inspired by vim and
ranger.

![Last commit shield](https://img.shields.io/github/last-commit/chrisgrieser/finder-vim-mode?style=plastic)

![Finder vim cheatsheet](./extras/cheatsheet.png)

## Usage examples
- `wl`: Duplicate selected file and open the copy.
- `axq`: Select all files, move them to the other window, close current window.
- `.f.d.`: Show hidden files, select first hidden file, delete it, hide dotfiles
  again.
- `AM`: Select files (but not folders), create a new directory, move selected
  files into that directory, and start renaming the directory (enters insert
  mode).
- `azmhp`: Select all files and folders, zip them (and wait for zipping to
  finish), and move the archive one directory up

## Table of contents

<!-- toc -->

- [Usage](#usage)
- [Installation](#installation)
- [Updates](#updates)
- [Caveats](#caveats)
- [Build](#build)
- [Credits](#credits)
- [About the developer](#about-the-developer)

<!-- tocstop -->

## Usage
- Only works in Finder's `List View`.
- __`:help`__ Press `?` in Finder to display the cheatsheet above. Generally,
  everything in brackets only applies to the uppercase version of the key.
- __Move__: `m` marks the current selection as "to be moved." The next
  paste-operation `p` moves the files. A move can be aborted via `esc`.
- __Cross-move__: If you have *exactly* two Finder windows open, `x` moves the
  selection to the other window, and `X` copies the selection to the other
  window.
- __Context-menu__: Can be opened with `c` and navigated via `hjkl`. Press
  `esc`, `q`, or `c` to close the context-menu.
- __Find mode__ is triggered via `f`, works similar to `f` in vim, expecting
  another character afterward. For example, `fh` jumps to the next file that
  starts with the letter `h`.
- __Toggle `-bkp` suffix__: Add suffix `-bkp` to the file. If it already has
  such a suffix, remove it. Useful for debugging as well.
- __`Tab`__ goes to the next file in alphabetical order, *even when the view is
  not sorted alphabetically.* (This is actually a built-in feature of Finder,
  but worth mentioning since barely anyone knows about it.)
- __Copy/Paste file content:__ `Y` copies the content of the selected file, while
  `P` pastes text from the clipboard into the selected file (appending).

> [!NOTE]
> __Pressing `return` in a prompt window__, for example when replacing a file,
> mistakenly puts you in Insert Mode. Unfortunately, Karabiner is not able to
> detect whether the front window is a regular Finder window or a prompt. The
> workaround is to either press `esc` to go back to Normal Mode, or to use `tab`
> and then `space` to select the correct action in the prompt window.

## Installation
This plugin requires you to have __English as your System UI language__. (You
can set the language via: `System Settings → General → Language & Region →
Preferred Languages`)

1. Run this in your terminal:

    ```bash
    brew install karabiner-elements # Install Karabiner (if not already installed)

    worktree="https://raw.githubusercontent.com/chrisgrieser/finder-vim-mode/main"
    open "karabiner://karabiner/assets/complex_modifications/import?url=$worktree/finder-vim.json"
    curl -sL "$worktree/extras/cheatsheet.png" --create-dirs --output "$HOME/.config/karabiner/assets/finder-vim-mode/cheatsheet.png"
    curl -sL "$worktree/extras/notificator" --create-dirs --output "$HOME/.config/karabiner/assets/finder-vim-mode/notificator"

    # set default view to "List"
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
    # optional: disable desktop icons & make desktop unfocussable
    defaults write com.apple.finder CreateDesktop false
    # restart Finder for changes to take effect
    killall Finder
    ```

2. Activate the plugin: `Import` → `Enable`
3. *Karabiner users:* If you already use Karabiner and have another modification
   affecting the `Capslock` key, the other modification must come __below__ the
   *Finder Vim Mode* in the list of modifications. (Karabiner prioritizes
   modifications further on top of the list.)
   <!-- LTeX: enabled=false -->
4. *Alfred users:* In [the Appearance
   Options](https://www.alfredapp.com/help/appearance/#options), you need to set
   the `Focusing` behavior to `Compatibility Mode` for Karabiner to detect
   Alfred being active.
   <!-- LTeX: enabled=true -->
5. *Spotlight/Raycast users:* You need to install the Spotlight add-on. The add-on 
   has to be __above__ the Finder Vim Mode in Karabiner's list of modifications.

    ```bash
    # install Spotlight/Raycast addon
    open "karabiner://karabiner/assets/complex_modifications/import?url=https://raw.githubusercontent.com/chrisgrieser/finder-vim-mode/main/addons/finder-vim-spotlight-addon.json"
    ```

## Updates
Unfortunately, Karabiner has no mechanism for auto-updating plugins. Therefore,
you have to install updates manually by re-running the code above. You can check
the last commit date to see whether there has been an update:

![Last commit shield](https://img.shields.io/github/last-commit/chrisgrieser/finder-vim-mode?style=plastic)

## Caveats
Since Karabiner plugins are only hotkey re-mappings without proper scripting
mechanisms, this plugin has some limitations:
- Only __List view__ is supported.
- If you __use the mouse to click buttons__, you can end up in the wrong mode.
  In that case, you can press `esc` to get back to Normal Mode.
- File selection dialogues from other apps (for example to upload a file in the
  browser) are not supported.
- Unfortunately, it is __not possible to have a `vimrc` or to let the user
  configure the keybindings__ themselves in any way, at least not with a
  Karabiner plugin. If you want to rebind keys, you have to change the
  respective key manually in the JSON file.
- If you have set __custom keybindings for Finder__, they can potentially
  interfere. It is therefore recommended to unset them.
- The plugin has been tested with the __US and German keyboard layout__. It
  should mostly also work for other layouts.

## Build
Karabiner plugins are essentially hotkey configurations in form of a JSON file.
The amount of configurations for this plugin is rather large; the
resulting JSON file is ~8000 lines of code. To make that ankommt manageable,
this plugin is written in YAML where features such as [anchors and
aliases](https://www.linode.com/docs/guides/yaml-anchors-aliases-overrides-extensions/)
reduce the lines of code to ~1300.

If you want to fork this plugin, it is recommended to work with the YAML file
and "compile" it to the [JSON required by
Karabiner](https://karabiner-elements.pqrs.org/docs/json/complex-modifications-manipulator-definition/).
You can do so with [yq](https://github.com/mikefarah/yq):

```bash
# `explode()` is required to resolve the anchors and aliases
yq --output-format=json 'explode(.)' finder-vim.yaml > finder-vim.json
```

## Credits
- The cheatsheet has been created with <http://www.keyboard-layout-editor.com/>.
- The notification script is a modified version of the [Notificator by Vítor
  Galvão](https://github.com/vitorgalvao/notificator).

## About the developer
In my day job, I am a sociologist studying the social mechanisms underlying the
digital economy. For my PhD project, I investigate the governance of the app
economy and how software ecosystems manage the tension between innovation and
compatibility. If you are interested in this subject, feel free to get in touch.

- [Website](https://chris-grieser.de/)
- [ResearchGate](https://www.researchgate.net/profile/Christopher-Grieser)
- [Mastodon](https://pkm.social/@pseudometa)
- [LinkedIn](https://www.linkedin.com/in/christopher-grieser-ba693b17a/)

<a href='https://ko-fi.com/Y8Y86SQ91' target='_blank'> <img height='36'
style='border:0px;height:36px;' src='https://cdn.ko-fi.com/cdn/kofi1.png?v=3'
border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>
