return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            preset = "modern",
            --title_pos = "center",
            delay = 100,
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-mini/mini.pairs",
        config = function(_, _)
            return { opts = { modes = false } }
        end,
    },
    {
        "tpope/vim-sleuth",
        event = { "BufReadPre", "BufNewFile" },
    },
}
