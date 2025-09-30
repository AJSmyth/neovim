return {
    -- Treesitter context toggle
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "LazyFile",
        opts = function()
            local tsc = require("treesitter-context")
            Snacks.toggle({
                name = "Treesitter Context",
                get = tsc.enabled,
                set = function(state)
                    if state then
                        tsc.enable()
                    else
                        tsc.disable()
                    end
                end,
            }):map("<leader>ut")
            return { mode = "cursor", max_lines = 6, separator = "─" }
        end,
    },

    -- Ensure markdown + inline parser installed for inline code highlighting
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = opts.ensure_installed or {}
            local ensure = opts.ensure_installed
            local function add(lang)
                if type(ensure) == "table" and not vim.tbl_contains(ensure, lang) then
                    table.insert(ensure, lang)
                end
            end
            for _, lang in ipairs({
                "markdown",
                "markdown_inline", -- needed for inline `code` and emphasis
                "lua",
                "bash",
                "python",
                "json",
                "diff", -- icons & disable background logic
                "rust",
            }) do
                add(lang)
            end
        end,
    },
}
