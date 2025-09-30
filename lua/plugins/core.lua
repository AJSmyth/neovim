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
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            disable_frontmatter = true,
            workspaces = {
                {
                    name = "tp-link",
                    path = "/mnt/c/Users/aj.smyth/Documents/obsidian/tp-link/",
                },
            },
        },
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
}
