return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = function()
            return {
                file_types = { "markdown" },
                code = {
                    width = "full",
                    border = "hide", -- hide border; custom extmarks will supply header
                    style = "full",
                    -- Disable built-in language header so our custom copilot_codeblock.lua
                    -- can render icon + name consistently across markdown & chat buffers.
                    language = false,
                    language_icon = false,
                    language_name = false,
                    language_info = false,
                },
                heading = { enabled = true, width = "full", border = false },
            }
        end,
        config = function(_, opts)
            require("render-markdown").setup(opts)
            -- ensure nord has sensible defaults for the plugin highlight groups
            local nord_bg = "#2E3440"
            local code_bg = "#3B4252"
            local function hl(name, val)
                vim.api.nvim_set_hl(0, name, val)
            end
            -- fill code bg across full width by linking plugin groups to our custom bg
            for _, g in ipairs({
                "RenderMarkdownCode",
                "RenderMarkdownCodeBorder",
                "RenderMarkdownCodeInline",
                "RenderMarkdownCodeInfo",
                "RenderMarkdownCodeFallback",
            }) do
                hl(g, { bg = code_bg })
            end
            -- headings background lines lighter variants (optional tweak)
            hl("RenderMarkdownH1Bg", { bg = code_bg })
            hl("RenderMarkdownH2Bg", { bg = code_bg })
            hl("RenderMarkdownH3Bg", { bg = code_bg })
            hl("RenderMarkdownH4Bg", { bg = code_bg })
            hl("RenderMarkdownH5Bg", { bg = code_bg })
            hl("RenderMarkdownH6Bg", { bg = code_bg })
        end,
    },
}
