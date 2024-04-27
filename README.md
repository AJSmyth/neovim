# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim) at Rekovar. 

# Install

## Requirements 
Has the same basic requirements as Lazyvim

## Make a backup of your current Neovim files:
```
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

## Clone the Starter 
`git clone http://10.0.1.162:3000/General/neovim_config ~/.config/nvim`

## Start Neovim 
`nvim`

# Other things to know
## Clangd  
In the the plugins folder clangd defines the lsp behavior. 
This has been hardcoded to the current nix compiler in use and will need to be updated it changes. 
