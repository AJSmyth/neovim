return {
    {
        "hrsh7th/nvim-cmp",
        opts = {
            sources = {
                -- Place Copilot higher in the list for a higher base priority
                { name = "nvim_lsp", group_index = 1, priority = 90 },
                { name = "copilot", group_index = 3, priority = 0 },
                { name = "luasnip", group_index = 1, priority = 50 },
                { name = "path", group_index = 2, priority = 10 },
            },
        },
    },
}
