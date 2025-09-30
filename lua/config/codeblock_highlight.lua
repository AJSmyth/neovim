-- Highlight adjustments for fenced + inline code blocks (Nord theme)
-- Provides a lighter background for entire code blocks and inline `code`.
-- Change the code_bg value below to pick a preferred shade.
--
-- Nord palette references (comments give you options):
-- Base (editor bg) : #2E3440
-- Option A (soft)  : #3B4252
-- Option B (medium): #434C5E
-- Option C (strong): #4C566A
-- Option D (blend) : #373E4C
-- Option E (alt)   : #39404D

local M = {}

local code_bg = "#3B4252" -- <- pick one of the options above
-- make sure ColorColumn/RenderMarkdownCode etc use full window fill style
vim.api.nvim_set_hl(0, "ColorColumn", { bg = code_bg })

local function apply()
    local groups = {
        -- Markdown legacy groups
        "markdownCode",
        "markdownCodeBlock",
        "markdownCodeDelimiter",
        "markdownInlineCode",

        -- Treesitter (modern markup groups)
        "@markup.raw",
        "@markup.raw.block",
        "@markup.raw.markdown_inline",
        "@markup.fenced_code_block",
        "@markup.raw.markdown",

        -- Possible plugin specific (render-markdown etc.)
        "RenderMarkdownCode",
        "RenderMarkdownCodeBorder",
        "RenderMarkdownCodeInline",
        "RenderMarkdownCodeInfo",
        "RenderMarkdownCodeFallback",
    }

    for _, g in ipairs(groups) do
        local ok, existing = pcall(vim.api.nvim_get_hl, 0, { name = g, link = false })
        existing = ok and existing or {}
        vim.api.nvim_set_hl(0, g, {
            bg = code_bg,
            fg = existing.fg and string.format("#%06x", existing.fg) or nil,
            italic = existing.italic,
            bold = existing.bold,
        })
    end

    -- Optional: stronger inline contrast (uncomment if desired)
    -- vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { bg = code_bg, fg = "#ECEFF4" })
end

-- Reapply whenever the colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("CodeBlockNordBG", { clear = true }),
    callback = apply,
})

apply()

return M
