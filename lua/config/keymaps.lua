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
vim.keymap.set("n", "<leader><Tab>O", function()
    vim.cmd("tabnew")
    vim.cmd("cd /mnt/c/Users/aj.smyth/Documents/obsidian/tp-link")
end, { desc = "Open Obsidian Vault" })

-- Translate keybindings under <leader>t
vim.keymap.set("n", "<leader>tc", "<cmd>Translate --comment<CR>", { desc = "Translate Comment" })
vim.keymap.set("n", "<leader>tt", "<cmd>Translate<CR>", { desc = "Auto Translate" })

-- Open arbitrary path with neo-tree --
vim.keymap.set("n", "<leader>fP", function()
    vim.ui.input({ prompt = "Open Neo-tree at path: ", completion = "dir" }, function(input)
        if input and input ~= "" then
            local expanded = vim.fn.expand(input)
            require("neo-tree.command").execute({
                action = "show",
                source = "filesystem",
                path = expanded, -- your expanded path
                reveal = true,
                dir = expanded, -- force Neo-tree to use this as root
            })
        end
    end)
end, { desc = "Open Neo-tree at custom path" })

vim.keymap.set({ "n", "v", "i", "c", "t" }, "<C-b>", "<Nop>", { noremap = true, silent = true })

require("which-key").add({
    { "<leader>t", group = "Translate" },
})

vim.keymap.set("n", "<leader>yc", function()
    local path = vim.api.nvim_buf_get_name(0)
    vim.fn.setreg("+", path)
    vim.notify("Yanked file path:\n" .. path)
end, { desc = "Yank current buffer file path" })

vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Go to previous context" })

--[[
require("which-key").add({
    { "<leader>o", group = "Obsidian" },
})

-- Define keymaps with descriptions (Lazy.nvim + which-key compatible)
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "New Obsidian Note" })
vim.keymap.set("n", "<leader>oD", "<cmd>ObsidianDailies<CR>", { desc = "Obsidian Dailies" })
vim.keymap.set("n", "<leader>od", "<cmd>ObsidianToday<CR>", { desc = "Obsidian Today" })
vim.keymap.set("n", "<leader>oo", function()
    vim.cmd("tabnew")
    vim.cmd("cd /mnt/c/Users/aj.smyth/Documents/obsidian/tp-link")
end, { desc = "Open Obsidian Vault" })
]]

-- Make Bufferline Keymaps Make Sense
vim.keymap.del("n", "<leader>br")
vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })
