local builtin = require("telescope.builtin")
local function find_files(hidden, ignored, cwd)
    local opts = {
        no_ignore = ignored,
        hidden = hidden,
    }
    if cwd then
        opts.cwd = cwd
    end
    builtin.find_files(opts)
end
return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },
    },
    keys = {
        {
            "<leader>sg",
            function()
                builtin.live_grep({
                    additional_args = { "--no-ignore", "--glob", "!.git/*" },
                })
            end,
            desc = "grep",
        },
        {
            "<leader>sG",
            function()
                local c = require("telescope.utils").buffer_dir()
                builtin.live_grep({
                    additional_args = { "--no-ignore", "--glob", "!.git/*" },
                    cwd = c,
                })
            end,
            desc = "grep (buf dir)",
        },
        {
            "<leader>ff",
            function()
                find_files(false, true, nil)
            end,
            desc = "Find Files",
        },
        {
            "<leader>fF",
            function()
                local c = require("telescope.utils").buffer_dir()
                find_files(false, true, c)
            end,
            desc = "Find Files (buf dir)",
        },
        { "<leader>/", enabled = false },
    },
    opts = function()
        local actions = require("telescope.actions")
        return {
            defaults = {
                mappings = {
                    i = {},
                    n = {
                        ["q"] = actions.close,
                    },
                },
            },
            pickers = {
                find_files = {
                    path_display = { "smart" },
                },
                live_grep = {
                    path_display = { "smart" },
                },
            },
        }
    end,
}
