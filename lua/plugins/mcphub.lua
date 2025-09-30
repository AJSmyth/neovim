return {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "bundled_build.lua", -- Bundles `mcp-hub` binary along with the neovim plugin
    config = function()
        require("mcphub").setup({
            use_bundled_binary = true, -- Use local `mcp-hub` binary
            extensions = {
                copilotchat = {
                    enabled = true,
                    convert_tools_to_functions = true,
                    convert_resources_to_functions = true,
                    add_mcp_prefix = false,
                },
            },
        })
    end,
}
