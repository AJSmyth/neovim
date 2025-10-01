# General Notes

## Highlights

[Nord Named Colors](https://github.com/shaunsingh/nord.nvim/blob/80c1e5321505aeb22b7a9f23eb82f1e193c12470/lua/nord/named_colors.lua) can be found here for easy hl customization. This can be useful when a plugin's highlights don't play nice with the theme.

Customized highlights are located in the `lua/config/highlights.lua` file.

# Telescope

## Keybinds

### Live Grep & Find Files

| Keybind | Action | Custom|
|--|--|--|
| `<C-q>` | Open multi-selected items in qf(swapped with `<M-q>`) | ✅|
| `<M-q>` | Open all filtered items in qf (swapped with `<C-q>`)| ✅|
|`<Tab>` | Multi-select | ❌|
|`<leader>gg` | Live Grep (cwd)| 🔃|
|`<leader>gG` | Live Grep (current buffer dir)| 🔃|
|`<leader>ff` | Find Files(cwd)| 🔃|
|`<leader>fF` | Find Files (current buffer dir)| 🔃|
