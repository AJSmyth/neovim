return {
    {
        "askfiy/smart-translate.nvim",
        cmd = { "Translate" },
        dependencies = {
            "askfiy/http.nvim", -- a wrapper implementation of the Python aiohttp library that uses CURL to send requests.
        },
        config = function()
            require("smart-translate").setup({
                default = {
                    cmds = {
                        source = "zh-CN", -- FROM Chinese
                        target = "en", -- TO English
                        handle = "float",
                        engine = "google",
                    },
                    cache = true,
                },
            })
        end,
    },
}
