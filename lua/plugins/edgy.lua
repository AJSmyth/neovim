return {
    {
        "folke/edgy.nvim",
        optional = true,
        opts = function(_, opts)
            opts.bottom = opts.bottom or {}
            table.insert(opts.bottom, {
                ft = "copilot-chat",
                title = "Copilot Chat",
                size = { height = 50 },
            })
        end,
    },
}
