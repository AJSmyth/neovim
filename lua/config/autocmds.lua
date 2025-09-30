-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_set_hl(0, "TrailingWhitespace", { bg = "#BF616A", fg = "#E5E9F0" })

-- 2) Helpers
local allowed_ft = { c = true, cpp = true, objc = true, objcpp = true }
local banned_ft =
    { alpha = true, lazy = true, starter = true, dashboard = true, ["neo-tree"] = true, TelescopePrompt = true }

local function add_match()
    -- Add only in normal, file-backed buffers of allowed filetypes
    if vim.bo.buftype ~= "" then
        return
    end
    if not allowed_ft[vim.bo.filetype] then
        return
    end
    if vim.w.trailing_ws_id then
        return
    end
    vim.w.trailing_ws_id = vim.fn.matchadd("TrailingWhitespace", [[\s\+$]])
end

local function clear_match()
    -- Remove any window-local match and also clear a stray :match if present
    if vim.w.trailing_ws_id then
        pcall(vim.fn.matchdelete, vim.w.trailing_ws_id)
        vim.w.trailing_ws_id = nil
    end
    pcall(function()
        vim.cmd("match none")
    end)
end

-- 3) Autocommands
local grp = vim.api.nvim_create_augroup("TrailingWsOnlyInC", { clear = true })

-- When a C/C++-family filetype is set, add match (in that window only)
vim.api.nvim_create_autocmd("FileType", {
    group = grp,
    pattern = { "c", "cpp", "objc", "objcpp" },
    callback = function()
        add_match()
    end,
})

-- On window/buffer changes, ensure the rule holds:
--  - present in allowed filetypes
--  - removed in dashboards, sidebars, help, etc.
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter", "BufWinEnter", "BufFilePost" }, {
    group = grp,
    callback = function()
        if banned_ft[vim.bo.filetype] or vim.bo.buftype ~= "" or not allowed_ft[vim.bo.filetype] then
            clear_match()
        else
            add_match()
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "objc", "objcpp", "h", "hpp" },
    callback = function()
        vim.opt_local.colorcolumn = "80,120"
        vim.opt_local.fixendofline = false
        vim.opt_local.expandtab = false
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.listchars = {
            space = "·",
            tab = ">-",
        }
    end,
})
