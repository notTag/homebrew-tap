# notTag/homebrew-tap

Homebrew formulae for [notTag](https://github.com/notTag) projects.

```sh
brew tap notTag/tap
```

## Formulae

### space-tag

Tag macOS spaces from your git project ([Space-Tag-CLI](https://github.com/notTag/Space-Tag-CLI)).

```sh
brew trust --tap notTag/tap               # brew gates non-official taps
brew install notTag/tap/space-tag
"$(brew --prefix space-tag)/install.sh"   # symlinks configs + shell hook
yabai --start-service
brew services start sketchybar
exec $SHELL
```

`jq` comes in as a formula dependency; `install.sh` installs `yabai` and
`sketchybar` from their official taps. yabai needs Accessibility
permission on first run (System Settings > Privacy & Security > Accessibility).

Uninstall with `space-tag uninstall`, then `brew uninstall space-tag`.
