return {
    { -- This helps with php/html for indentation
        'captbaritone/better-indent-support-for-php-with-html',
    },
    { -- Git plugin
        'tpope/vim-fugitive',
    },
    { -- Show CSS Colors
        'brenoprata10/nvim-highlight-colors',
        config = function()
            require('nvim-highlight-colors').setup({})
        end
    },
}
