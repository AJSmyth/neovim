-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

vim.keymap.set("n", "<C-_>", function()
    Util.terminal(nil, { border = "rounded" })
end, { desc = "Term with border" })
vim.keymap.set("n", "<leader>uS", function()
    vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
end, { desc = "Open mini starter" })
vim.keymap.set("n", "<leader>uP", function()
    LazyVim.pick.config_files()()
end, { desc = "Config" })
