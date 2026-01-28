local link_to_inactive = {
    "SnacksPickerTotals",
    "SnacksPickerFile",
    "SnacksPickerPathIgnored",
    "SnacksPickerPathHidden",
    "SnacksPickerDir",
    "SnacksPickerUnselected",
    "SnacksPickerBufFlags",
    "SnacksPickerKeymapRhs",
    "SnacksPickerGitStatusUntracked",
    "SnacksPickerGitStatusIgnored",
}
local comment_hl = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
local inactive_hl = {
    fg = comment_hl.fg,
    bg = comment_hl.bg,
    italic = false,
}
vim.api.nvim_set_hl(0, "CustomInactive", inactive_hl)
for _, name in ipairs(link_to_inactive) do
    vim.api.nvim_set_hl(0, name, { link = "CustomInactive" })
end

vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#333a47" })
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "#434c5e" })
