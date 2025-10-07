return {
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        version = false, -- latest
        dependencies = { "nvim-lua/plenary.nvim" },
        cmd = { "CopilotChat", "CopilotChatToggle" },

        opts = function()
            local icons = {
                ui = {
                    User = " User",
                    Bot = "󱚤 Bot",
                    Tool = " Tool",
                },
            }
            return {
                model = "gpt-5",
                debug = false,
                temperature = 0,
                sticky = { "#buffers", "@copilot", "@neovim", "@mcphub", "@atlassian" },
                diff = "block",
                chat_autocomplete = false,
                separator = ":",
                show_help = false,
                highlight_headers = false, -- disable header highlighting so we can use render-markdown instead
                stop_on_function_failure = true,
                window = {
                    width = 0.3,
                },
                headers = {
                    user = icons.ui.User,
                    assistant = icons.ui.Bot,
                    tool = icons.ui.Tool,
                },
                mappings = {
                    reset = false,
                    complete = { insert = "<Tab>" },
                },
                prompts = {
                    Explain = { mapping = "<leader>ae", description = "AI Explain" },
                    Review = { mapping = "<leader>ar", description = "AI Review" },
                    Tests = { mapping = "<leader>at", description = "AI Tests" },
                    Fix = { mapping = "<leader>af", description = "AI Fix" },
                    Optimize = { mapping = "<leader>ao", description = "AI Optimize" },
                    Docs = { mapping = "<leader>ad", description = "AI Documentation" },
                    Commit = { mapping = "<leader>ac", description = "AI Generate Commit" },
                },
            }
        end,
        config = function(_, opts)
            local chat = require("CopilotChat")
            chat.setup(opts)
            -- chat buffer UI tweaks
            vim.api.nvim_create_autocmd("BufEnter", {
                pattern = "copilot-*",
                callback = function()
                    vim.opt_local.relativenumber = false
                    vim.opt_local.number = false
                    vim.opt_local.signcolumn = "no"
                    vim.opt_local.conceallevel = 2
                end,
            })
            -- which-key group (if which-key present)
            pcall(function()
                require("which-key").add({ { "<leader>a", group = "AI" } })
            end)
        end,
    },
}
