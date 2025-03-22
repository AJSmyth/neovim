return {
    { "shaunsingh/nord.nvim" },
    {
        "chomosuke/typst-preview.nvim",
        lazy = false, -- or ft = 'typst'
        version = "1.*",
        opts = {}, -- lazy.nvim will implicitly calls `setup {}`
    },
    {
        "echasnovski/mini.surround",
        version = "*",
        opts = {
            mappings = {
                add = "", -- Disable default keybindings
                delete = "",
                find = "",
                find_left = "",
                highlight = "",
                replace = "",
                update_n_lines = "",
            },
        },
        config = function(_, opts)
            require("mini.surround").setup(opts)

            -- Define <leader>m as prefix for all mappings
            local keymap = vim.keymap.set
            local leader_m = "<leader>m"

            keymap("n", leader_m .. "a", "sa", { desc = "Add surrounding" })
            keymap("v", leader_m .. "a", "S", { desc = "Add surrounding (visual mode)" })
            keymap("n", leader_m .. "d", "sd", { desc = "Delete surrounding" })
            keymap("n", leader_m .. "f", "sf", { desc = "Find surrounding" })
            keymap("n", leader_m .. "F", "sF", { desc = "Find surrounding (left)" })
            keymap("n", leader_m .. "h", "sh", { desc = "Highlight surrounding" })
            keymap("n", leader_m .. "r", "sr", { desc = "Replace surrounding" })
            keymap("n", leader_m .. "n", "sn", { desc = "Update n-lines" })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "tinymist",
            },
        },
    },
    { "akinsho/toggleterm.nvim" },
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "nord",
        },
    },
    {
        "Dronakurl/injectme.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        -- This is for lazy load and more performance on startup only
        cmd = { "InjectmeToggle", "InjectmeSave", "InjectmeInfo", "InjectmeLeave" },
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
        lazy = false, -- This plugin is already lazy
    },
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            dashboard = { enabled = true },
            explorer = { enabled = false },
            indent = { enabled = true },
            input = { enabled = true },
            picker = { enabled = true },
            notifier = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
        },
    },
    -- change some telescope options and a keymap to browse plugin files
    {
        "nvim-telescope/telescope.nvim",
        keys = {
        -- add a keymap to browse plugin files
        -- stylua: ignore
        {
          "<leader>fp",
          function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
          desc = "Find Plugin File",
        },
        },
        -- change some options
        opts = {
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { prompt_position = "top" },
                sorting_strategy = "ascending",
                winblend = 0,
            },
        },
    },
    {
        "ellisonleao/glow.nvim",
        config = true,
        cmd = "Glow",
        opts = {
            pager = false,
            width_ratio = 1.0, -- maximum width of the Glow window compared to the nvim window size (overrides `width`)
            height_ratio = 1.0,
        },
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            preset = "modern",
            delay = 0,
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
}
