return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                -- enable syntax highlighting
                highlight = {
                    enable = true,
                },
                -- enable indentation
                indent = { enable = true },
                -- enable autotagging (w/ nvim-ts-autotag plugin)
                autotag = { enable = true },
                -- ensure these language parsers are installed
                ensure_installed = {
                    "json",
                    "javascript",
                    "html",
                    "css",
                    "markdown",
                    "bash",
                    "lua",
                    "c",
		    "cpp",
                    },
                -- auto install above language parsers
                auto_install = false,
            })
        end
    }
}
