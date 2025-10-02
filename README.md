# General Notes

## Highlights

[Nord Named Colors](https://github.com/shaunsingh/nord.nvim/blob/80c1e5321505aeb22b7a9f23eb82f1e193c12470/lua/nord/named_colors.lua) can be found here for easy hl customization. This can be useful when a plugin's highlights don't play nice with the theme.

```lua
local nord = {
 --16 colors
 black = "#2E3440", -- nord0 in palette
 dark_gray = "#3B4252", -- nord1 in palette
 gray = "#434C5E", -- nord2 in palette
 light_gray = "#4C566A", -- nord3 in palette
 light_gray_bright = "#616E88", -- out of palette
 darkest_white = "#D8DEE9", -- nord4 in palette
 darker_white = "#E5E9F0", -- nord5 in palette
 white = "#ECEFF4", -- nord6 in palette
 teal = "#8FBCBB", -- nord7 in palette
 off_blue = "#88C0D0", -- nord8 in palette
 glacier = "#81A1C1", -- nord9 in palette
 blue = "#5E81AC", -- nord10 in palette
 red = "#BF616A", -- nord11 in palette
 orange = "#D08770", -- nord12 in palette
 yellow = "#EBCB8B", -- nord13 in palette
 green = "#A3BE8C", -- nord14 in palette
 purple = "#B48EAD", -- nord15 in palette
 none = "NONE",
}
```

Customized highlights are located in the `lua/config/highlights.lua` file.

## Telescope

### Keybinds

#### Live Grep & Find Files

| Keybind | Action | Custom|
|--|--|--|
| `<C-q>` | Open multi-selected items in qf(swapped with `<M-q>`) | ✅|
| `<M-q>` | Open all filtered items in qf (swapped with `<C-q>`)| ✅|
|`<Tab>` | Multi-select | ❌|
|`<leader>gg` | Live Grep (cwd)| 🔃|
|`<leader>gG` | Live Grep (current buffer dir)| 🔃|
|`<leader>ff` | Find Files(cwd)| 🔃|
|`<leader>fF` | Find Files (current buffer dir)| 🔃|
|`:ccl` | Close quickfix list | ❌|

## Obsidian

- Bufferline is used to filter out obsidian notes when the tab cwd isn't the vault root. When the tab cwd is the vault root, only obsidian notes are shown in the bufferline.

### Keybinds

| Keybind | Action | Custom|
|--|--|--|
| `<leader><Tab><Tab>` | Open/switch to Obsidian Tab. | ✅|
