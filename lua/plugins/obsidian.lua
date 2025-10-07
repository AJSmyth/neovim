return {
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
                    path = function()
                        return require("plugins.obsidian.actions").get_vault_dir()
                    end,
                },
            },
            daily_notes = {
                folder = {
                    "Daily",
                },
            },
            mappings = {
                -- Toggle check-boxes.
                ["<Tab>"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
            },
        },
        config = function(_, opts)
            require("obsidian").setup(opts)
        end,
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
}
