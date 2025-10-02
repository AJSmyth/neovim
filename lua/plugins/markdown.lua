return {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown", "copilot-chat" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        opts = function()
            return {
                render_modes = true,
                heading = {
                    sign = true,
                    width = "block",
                    min_width = 100,
                    left_pad = 1,
                    border = true,
                    border_virtual = true,
                    backgrounds = {
                        "Headline1",
                        "Headline2",
                        "Headline3",
                        "Headline4",
                        "Headline5",
                        "Headline6",
                    },
                },
                bullet = {
                    icons = { "•", "◦", "▪", "▫", "⁃", "◉", "○", "◆", "◇", "▶", "▷" },
                    right_pad = 5,
                },
                checkbox = {
                    right_pad = 5,
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
                anti_conceal = {
                    ignore = {
                        heading = true,
                        code_border = false,
                        code_background = false,
                        indent = true,
                        sign = true,
                        virtual_lines = true,
                    },
                },
                overrides = {
                    filetype = {
                        ["copilot-chat"] = {
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
                                    "Headline5",
                                    "Headline2",
                                    "Headline1",
                                    "Headline6",
                                },
                            },
                        },
                    },
                },
            }
        end,
        config = function(_, opts)
            require("render-markdown").setup(opts)
        end,
    },
}
