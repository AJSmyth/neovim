-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- use escape to exit insert mode in terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- custom buffer stuffs
vim.keymap.set("n", "<leader>bn", "<Cmd>enew<CR>", { silent = true, desc = "New empty buffer" })
vim.keymap.set("n", "<leader>bt", "<Cmd>terminal<CR>", { silent = true, desc = "New terminal buffer" })
