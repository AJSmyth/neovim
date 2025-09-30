return {
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
                    language_name = false,
                    language_info = true,
                    conceal_delimiters = true,
                    border = "thick",
                },
                heading = {
                    enabled = false,
                },
            }
        end,
        config = function(_, opts)
            require("render-markdown").setup(opts)
        end,
    },
}
