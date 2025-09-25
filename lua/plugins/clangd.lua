return {
    {
        "neovim/nvim-lspconfig",
        priority = 1000, -- load our opts late so they win
        opts = function(_, opts)
            local cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=never", -- don't auto-insert includes
                "--completion-style=detailed",
                "--function-arg-placeholders=0", -- no snippet placeholders
                "--fallback-style=LLVM",
            }

            opts.servers = opts.servers or {}
            opts.servers.clangd = vim.tbl_deep_extend("force", opts.servers.clangd or {}, {
                cmd = cmd,
                init_options = { usePlaceholders = false }, -- belt & suspenders
            })

            -- Ensure *we* set it up and block any default reconfig
            opts.setup = opts.setup or {}
            opts.setup.clangd = function(_, server_opts)
                require("lspconfig").clangd.setup(server_opts)
                return true -- tell LazyVim we've handled clangd; don't override
            end
        end,
    },

    -- If you *also* have clangd_extensions installed and want to keep it,
    -- our setup hook above already wins. If you'd rather disable it entirely:
    -- { "p00f/clangd_extensions.nvim", enabled = false },
}
