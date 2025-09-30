-- Example dynamic function exposing all keymaps as a resource
require("CopilotChat.config").functions.keymaps = {
    description = "Show all globally defined keymaps",
    uri = "neovim://keymaps",
    resolve = function()
        local maps = vim.api.nvim_get_keymap("n")
        local lines = {}
        for _, map in ipairs(maps) do
            table.insert(lines, string.format("%-10s -> %s [%s]", map.lhs, map.rhs or "", map.desc or ""))
        end
        return { { data = table.concat(lines, "\n"), uri = "neovim://keymaps" } }
    end,
}
