-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Translation
require("which-key").add({
    { "<leader>t", group = "Translate" },
})
vim.keymap.set("n", "<leader>tc", "<cmd>Translate --comment<CR>", { desc = "Translate Comment" })
vim.keymap.set("n", "<leader>tt", "<cmd>Translate<CR>", { desc = "Auto Translate" })

vim.keymap.set({ "n", "v", "i", "c", "t" }, "<C-b>", "<Nop>", { noremap = true, silent = true })

-- Miscellaneous
vim.keymap.set("n", "<leader>yc", function()
    local path = vim.api.nvim_buf_get_name(0)
    vim.fn.setreg("+", path)
    vim.notify("Yanked file path:\n" .. path)
end, { desc = "Yank current buffer file path" })
vim.keymap.set("n", "[c", function()
    require("treesitter-context").go_to_context(vim.v.count1)
end, { silent = true, desc = "Go to previous context" })

-- Obsidian
vim.keymap.set("n", "<leader><Tab><Tab>", function()
    require("plugins.obsidian.actions").start()
end, { desc = "Open Obsidian Vault" })

-- Make Bufferline Keymaps Make Sense
vim.keymap.del("n", "<leader>br")
vim.keymap.set("n", "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right" })

-- Markdown: Toggle checkbox (- [ ] <-> - [x]) on current line
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(args)
        vim.keymap.set("n", "<Tab>", function()
            local line = vim.api.nvim_get_current_line()
            local new
            if line:match("^%s*%- %[%s%]%s") or line:match("^%s*%- %[%s%]$") then
                new = line:gsub("%- %[%s%]", "- [x]", 1)
            elseif line:match("^%s*%- %[[xX]%]%s") or line:match("^%s*%- %[[xX]%]$") then
                new = line:gsub("%- %[[xX]%]", "- [ ]", 1)
            else
                return
            end
            vim.api.nvim_set_current_line(new)
        end, { buffer = args.buf, desc = "Toggle Checkbox" })
    end,
})
