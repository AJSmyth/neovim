-- Custom styling for CopilotChat (or similar) code blocks
-- Adds Nerd Font icon + language label and full-line background highlight
-- Assumes CopilotChat buffers use markdown fences rendered via conceal or extmarks.
-- Strategy:
-- 1. Detect code fence regions by pattern ^```(lang)? ... ```
-- 2. Apply a virtual line (or inline virt text on first fence line) containing icon + language
-- 3. Apply full-line background highlight to each line inside the fence (including the fence markers)
-- 4. Re-run on BufEnter, TextChanged, and when LSP/completions update buffer

local M = {}

-- Map of language -> Nerd Font icon (fallback to  )
local icons = {
    lua = "",
    python = "",
    javascript = "",
    typescript = "",
    ts = "",
    json = "",
    yaml = "",
    yml = "",
    sh = "",
    bash = "",
    zsh = "",
    c = "",
    cpp = "",
    objc = "",
    objcpp = "",
    rust = "",
    go = "",
    html = "",
    css = "",
    scss = "",
    sql = "",
    docker = "",
    dockerfile = "",
    make = "",
    vim = "",
    markdown = "",
    md = "",
}

local ns = vim.api.nvim_create_namespace("copilot_codeblock")

-- Reuse the same background color used for markdown code blocks if available
local function get_code_bg()
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "markdownCodeBlock", link = false })
    if ok and hl.bg then
        return string.format("#%06x", hl.bg)
    end
    ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = "@markup.raw.block", link = false })
    if ok and hl.bg then
        return string.format("#%06x", hl.bg)
    end
    return "#3B4252" -- nord soft fallback
end

local function define_hl()
    local bg = get_code_bg()
    vim.api.nvim_set_hl(0, "CopilotChatCodeBG", { bg = bg })
    vim.api.nvim_set_hl(0, "CopilotChatCodeHeader", { bg = bg, bold = true })
end

-- Patterns for opening/closing fences. Capture optional language (can be empty)
-- Allow trailing attributes/comments after the language (so don't anchor end on open)
local open_fence_re = "^```%s*([%w_+-]*)"
local close_fence_re = "^```%s*$"

local function clear(buf)
    if vim.api.nvim_buf_is_loaded(buf) then
        vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
    end
end

local function applicable(buf)
    buf = buf or 0
    local name = vim.api.nvim_buf_get_name(buf)
    local ft = vim.bo[buf].filetype
    -- Be permissive: run in any scratch / markdown / copilot related buffer that has at least one fence
    if ft == "copilot-chat" or ft == "markdown" or name:match("copilot") then
        local max = math.min(80, vim.api.nvim_buf_line_count(buf))
        local lines = vim.api.nvim_buf_get_lines(buf, 0, max, false)
        for _, l in ipairs(lines) do
            if l:match("^```") then
                return true
            end
        end
    end
    return false
end

local function render(buf)
    buf = buf or 0
    if not applicable(buf) then
        return
    end
    clear(buf)
    define_hl()

    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local in_block = false
    local block_lang = nil

    for i, line in ipairs(lines) do
        local row = i - 1
        if not in_block then
            local lang = line:match(open_fence_re)
            if lang ~= nil then
                in_block = true
                block_lang = (lang ~= "" and lang) or "text"
                local icon = icons[block_lang] or ""
                local display_lang = block_lang:gsub("^%l", string.upper)
                local label = string.format(" %s  %s ", icon, display_lang)
                -- Pad to at least original fence length (3 backticks + lang)
                if #label < #line then
                    label = label .. string.rep(" ", (#line - #label))
                end
                vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
                    virt_text = { { label, "CopilotChatCodeHeader" } },
                    virt_text_pos = "overlay",
                    -- High priority to override render-markdown / copilot-chat language tags
                    priority = 20000,
                    line_hl_group = "CopilotChatCodeBG", -- full width background
                })
            end
        else
            if line:match(close_fence_re) then
                -- closing fence line
                vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
                    priority = 19999,
                    line_hl_group = "CopilotChatCodeBG",
                })
                in_block = false
                block_lang = nil
            else
                vim.api.nvim_buf_set_extmark(buf, ns, row, 0, {
                    priority = 19999,
                    line_hl_group = "CopilotChatCodeBG",
                })
            end
        end
    end
end

function M.refresh(buf)
    pcall(render, buf or 0)
end

function M.setup_autocmd()
    local grp = vim.api.nvim_create_augroup("CopilotChatCodeBlockEnhance", { clear = true })
    vim.api.nvim_create_autocmd(
        { "BufEnter", "BufWinEnter", "TextChanged", "TextChangedI", "BufWritePost", "ColorScheme" },
        {
            group = grp,
            pattern = "*",
            callback = function(args)
                -- Defer so we run after render-markdown / other providers place extmarks
                vim.schedule(function()
                    M.refresh(args.buf)
                end)
            end,
        }
    )
    vim.api.nvim_create_user_command("CopilotCodeBlocksRefresh", function(opts)
        M.refresh(0)
    end, { desc = "Re-render Copilot/Markdown code block headers" })
end

M.setup_autocmd()

return M
