local M = {}

local function ordinal(n)
    local rem100 = n % 100
    if rem100 < 11 or rem100 > 13 then
        local last = n % 10
        if last == 1 then
            return n .. "st"
        elseif last == 2 then
            return n .. "nd"
        elseif last == 3 then
            return n .. "rd"
        end
    end
    return n .. "th"
end

local function get_daily(ts)
    local t = ts or os.time()
    local weekday = os.date("%A", t) -- Full weekday name
    local month = os.date("%b", t) -- Abbreviated month name
    local day = ordinal(tonumber(os.date("%d", t)))
    local year = os.date("%Y", t)
    local week = os.date("%V", t) -- ISO week number
    return string.format("%s, %s %s %s (w%s).md", weekday, month, day, year, week)
end

function M.get_vault_dir()
    return "/mnt/c/Users/aj.smyth/Documents/obsidian/tp-link"
end

function M.bufferline_filter(bufnr)
    local vault_root = M.get_vault_dir()
    local name = vim.api.nvim_buf_get_name(bufnr)
    if name == "" then
        return true -- keep unnamed buffers
    end
    local cwd = vim.fn.getcwd()
    local is_vault_buf = name:sub(1, #vault_root) == vault_root

    if cwd == vault_root then
        return is_vault_buf
    else
        return not is_vault_buf
    end
end

function M.start()
    local vault = M.get_vault_dir()
    local target = vim.loop.fs_realpath(vault)

    -- If current tab's cwd is already the vault, switch to the first tab instead.
    do
        local current_tab = vim.api.nvim_get_current_tabpage()
        local current_tabnr = vim.api.nvim_tabpage_get_number(current_tab)
        local cwd = vim.fn.getcwd(-1, current_tabnr)
        if cwd ~= "" then
            local real = vim.loop.fs_realpath(cwd)
            if real == target then
                for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
                    if vim.api.nvim_tabpage_get_number(tab) == 1 then
                        vim.api.nvim_set_current_tabpage(tab)
                        return
                    end
                end
                return -- no first tab found (should not happen)
            end
        end
    end

    -- Otherwise, try to locate an existing tab whose cwd is the vault.
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
        local tabnr = vim.api.nvim_tabpage_get_number(tab)
        local cwd = vim.fn.getcwd(-1, tabnr)
        if cwd ~= "" then
            local real = vim.loop.fs_realpath(cwd)
            if real == target then
                vim.api.nvim_set_current_tabpage(tab)

                -- Show the first loaded buffer that belongs to the vault; if none, open today's daily note.
                local opened = false
                for _, b in ipairs(vim.api.nvim_list_bufs()) do
                    if vim.api.nvim_buf_is_loaded(b) then
                        local name = vim.api.nvim_buf_get_name(b)
                        if name ~= "" and name:sub(1, #vault) == vault then
                            pcall(vim.api.nvim_set_current_buf, b)
                            opened = true
                            break
                        end
                    end
                end
                if not opened then
                    vim.cmd("edit " .. vault .. "/Daily/" .. get_daily())
                end
                return
            end
        end
    end

    -- If not found, open a new tab with today's daily note and set tab-local cwd.
    vim.cmd("tabnew " .. vault .. "/Daily/" .. get_daily())
    vim.cmd("tcd " .. vault)
end
return M
