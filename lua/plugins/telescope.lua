local builtin = require("telescope.builtin")
local function find_files(hidden, ignored, cwd, picker_title)
    local opts = {
        no_ignore = ignored,
        hidden = hidden,
        prompt_title = picker_title,
    }
    if cwd then
        opts.cwd = cwd
    end
    builtin.find_files(opts)
end
local grep_args = {
    "--no-ignore",
    "--g",
    "!.git/*",
    "-g",
    "!nvmp/build_dir/*",
    "-g",
    "!nvmp/staging_dir/*",
    "-g",
    "!nvmp/bin/*",
    "-g",
    "!doc/*",
    "-g",
    "!out/*",
}
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
                builtin.live_grep({ prompt_title = "Live Grep (cwd)", additional_args = grep_args })
            end,
            desc = "grep",
        },
        {
            "<leader>sG",
            function()
                local c = require("telescope.utils").buffer_dir()
                builtin.live_grep({ prompt_title = "Live Grep (buf dir)", additional_args = grep_args, cwd = c })
            end,
            desc = "grep (buf dir)",
        },
        {
            "<leader>ff",
            function()
                find_files(false, true, nil, "Find Files (cwd)")
            end,
            desc = "Find Files",
        },
        {
            "<leader>fF",
            function()
                local c = require("telescope.utils").buffer_dir()
                find_files(false, true, c, "Find Files (buf dir)")
            end,
            desc = "Find Files (buf dir)",
        },
        { "<leader>/", enabled = false },
    },
    opts = function(_, opts)
        local actions = require("telescope.actions")
        if not LazyVim.has("flash.nvim") then
            print("Doesn't have flash.nvim!")
            return
        end
        local function flash(prompt_bufnr)
            require("flash").jump({
                pattern = "^",
                label = { after = { 0, 0 } },
                search = {
                    mode = "search",
                    exclude = {
                        function(win)
                            return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
                        end,
                    },
                },
                action = function(match)
                    local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
                    picker:set_selection(match.pos[1] - 1)
                end,
            })
        end
        opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
            mappings = {
                n = {
                    s = flash,
                    ["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                },
                i = {
                    ["<c-s>"] = flash,
                    ["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
                    ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                    ["<C-c>"] = actions.close,
                },
            },
            --file_ignore_patterns = { "^nvmp/build_dir" },
            --todo: add mapping for switching between cwd and buffer dir
        })
        opts.pickers = {
            find_files = {
                path_display = { "filename_first" },
            },
            live_grep = {
                path_display = { "filename_first" },
            },
            lsp_references = {
                path_display = { "filename_first" },
                file_ignore_patterns = { ".*/nvmp/build_dir" },
            },
        }
    end,
}
