return {
    {
        "lukas-reineke/headlines.nvim",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            markdown = {
                headline_highlights = {
                    "Headline1",
                    "Headline2",
                    "Headline3",
                    "Headline4",
                    "Headline5",
                    "Headline6",
                },
                codeblock_highlight = "CodeBlock",
                dash_highlight = "Dash",
                quote_highlight = "Quote",
            },
        },
    },
    -- Full markdown rendering for markdown files
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = function()
            return {
                code = {
                    width = "full",
                    style = "full",
                    language = true,
                    language_icon = true,
                    language_name = true,
                    language_info = true,
                    conceal_delimiters = true,
                    border = "thick",
                },
                heading = {
                    enabled = true,
                    width = "full",
                    border = false,
                },
            }
        end,
    },
    -- Only render code blocks inside CopilotChat buffers
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "copilot-chat" },
        opts = function()
            return {
                change_events = { "ModeChanged" },
                render_modes = true,
                debounce = 100,
                anti_conceal = {
                    enabled = true,
                    ignore = {
                        code_background = true,
                        code_border = true,
                        code_language = true,
                    },
                },
                code = {
                    width = "full",
                    style = "full",
                    language = true,
                    language_icon = true,
                    language_name = true,
                    language_info = true,
                    conceal_delimiters = true,
                    border = "thick",
                    left_pad = 2,
                },
                heading = {
                    sign = true,
                    icons = { " " },
                    position = "inline",
                    width = "full",
                    left_margin = 0.5,
                    left_pad = 0.5,
                    right_pad = 0.5,
                    backgrounds = {
                        "Headline3",
                        "Headline4",
                        "Headline3",
                        "Headline2",
                        "Headline1",
                        "Headline6",
                    },
                },
            }
        end,
        config = function(_, opts)
            require("render-markdown").setup(opts)
        end,
    },
}
