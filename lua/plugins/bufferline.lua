return {
    {
        "akinsho/bufferline.nvim",
        opts = function(_, opts)
            opts = opts or {}
            opts.options = opts.options or {}
            opts.options.custom_filter = function(bufnr, _)
                return require("plugins.obsidian.actions").bufferline_filter(bufnr)
            end
            return opts
        end,
    },
}
