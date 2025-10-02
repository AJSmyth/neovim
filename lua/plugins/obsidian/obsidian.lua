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
                        require("plugins.obsidian.actions").get_vault_dir()
                    end,
                },
            },
        },
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
}
