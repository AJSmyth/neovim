-- TODO: convert to telescope
return {
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
                hidden = true,
                ignored = true,
                explorer = {
                    hidden = true,
                    follow_file = true,
                    ignored = true,
                },
                sources = {
                    files = {
                        ignored = true,
                        hidden = true,
                        exclude = { "compile_commands.json", "tags", "tags.lock", ".cache" },
                    },
                },
                grep = {
                    files = {
                        ignored = true,
                        hidden = true,
                    },
                },
            },
        },
        keys = {
            {
                "<leader>gG",
                function()
                    local uv = vim.uv or vim.loop
                    local cwd = uv.cwd()
                    local repos_file = cwd .. "/.repos"
                    local stat = uv.fs_stat(repos_file)

                    local function open_lazygit(dir)
                        dir = vim.fn.fnamemodify(dir, ":p")
                        local ok, snacks = pcall(require, "snacks")
                        if not ok or not snacks.lazygit then
                            vim.notify("Snacks.lazygit not available", vim.log.levels.ERROR)
                            return
                        end
                        snacks.lazygit.open({ cwd = dir })
                    end

                    if not stat then
                        open_lazygit(cwd)
                        return
                    end

                    local repos = {}
                    for line in io.lines(repos_file) do
                        local trimmed = line:match("^%s*(.-)%s*$")
                        if trimmed ~= "" and not trimmed:match("^#") then
                            local path, alias = trimmed:match("^(.-)%s*:%s*(.+)$")
                            if path and alias then
                                table.insert(repos, { path = path, alias = alias })
                            else
                                -- fallback: no alias, use path as alias
                                table.insert(repos, { path = trimmed, alias = trimmed })
                            end
                        end
                    end

                    if #repos == 0 then
                        open_lazygit(cwd)
                        return
                    elseif #repos == 1 then
                        open_lazygit(cwd .. "/" .. repos[1].path)
                        return
                    end

                    vim.ui.select(repos, {
                        prompt = "Select repo for lazygit",
                        format_item = function(item)
                            return item.alias
                        end,
                    }, function(choice)
                        if choice then
                            open_lazygit(cwd .. "/" .. choice.path)
                        end
                    end)
                end,
                desc = "Lazygit (Project)",
            },
            {
                "<leader>gg",
                function()
                    local ok, snacks = pcall(require, "snacks")
                    if not ok or not snacks.lazygit then
                        vim.notify("Snacks.lazygit not available", vim.log.levels.ERROR)
                        return
                    end
                    local bufname = vim.api.nvim_buf_get_name(0)
                    local dir
                    if bufname == "" then
                        dir = (vim.uv or vim.loop).cwd()
                    else
                        dir = vim.fn.fnamemodify(bufname, ":p:h")
                    end
                    snacks.lazygit.open({ cwd = dir })
                end,
                desc = "Lazygit (Buffer)",
            },
        },
    },
}
