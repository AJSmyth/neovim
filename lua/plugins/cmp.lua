return {
    {
        "hrsh7th/nvim-cmp",
        opts = {
            sources = {
                { name = "nvim_lsp", group_index = 1, priority = 90 },
                { name = "copilot", group_index = 3, priority = 0 },
                --{ name = "luasnip", group_index = 1, priority = 50 },
                { name = "path", group_index = 2, priority = 10 },
            },
        },
    },
}
