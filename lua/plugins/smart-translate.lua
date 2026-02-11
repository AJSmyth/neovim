return {
    {
        "askfiy/smart-translate.nvim",
        cmd = { "Translate" },
        dependencies = {
            "askfiy/http.nvim",
        },
        config = function()
            require("smart-translate").setup({
                default = {
                    cmds = {
                        source = "zh-CN",
                        target = "en",
                        handle = "float",
                        engine = "deepl",
                    },
                    cache = true,
                    engine = {
                        deepl = {
                            api_key = "$DEEPL_API_KEY",
                            base_url = "https://api-free.deepl.com/v2/translate",
                        },
                    },
                },
            })
        end,
    },
}
