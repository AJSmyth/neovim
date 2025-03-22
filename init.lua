-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("lspconfig")["tinymist"].setup({
    settings = {
        formatterMode = "typstyle",
        exportPdf = "onType",
        outputPath = "$dir/$name",
        semanticTokens = "disable",
    },
    root_dir = function(filename, bufnr)
        return vim.fn.getcwd()
    end,
})
require("mini.surround").setup()
require("injectme").setup({
    mode = "standard",
    -- "all"/ "none" if all/no injections should be activated on startup
    --    When you use, lazy loading, call :InjectemeInfo to activate
    -- "standard", if no injections should be changed from standard settings in
    --    the runtime directory, i.e. ~/.config/nvim/queries/<language>/injections.scm
    reload_all_buffers = true,
    -- after toggling an injection, all buffers are reloaded to reset treesitter
    -- you can set this to false, and avoid that the plugin asks you to save buffers
    -- before changing an injection
    reset_treesitter = true,
    -- after toggling an injections, the treesitter parser is reset
    -- Currently, this does nothing, see this discussion on github
    -- https://github.com/nvim-treesitter/nvim-treesitter/discussions/5684
})
vim.g.neovide_floating_corner_radius = 10.0
