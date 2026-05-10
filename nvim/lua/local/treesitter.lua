local M = {
    'nvim-treesitter/nvim-treesitter', -- provides ASTs and syntax highlighting
    lazy = false,
    build = ':TSUpdate',
    dependencies = {
        {'JoosepAlviste/nvim-ts-context-commentstring'},
    },
}



M.config = function()
    vim.g.skip_ts_context_commentstring_module = true

    require('nvim-treesitter').setup {
        install = {
            'lua',
            'bash',
            'c',
            'hcl',
            'css',
            'dockerfile',
            'elm',
            'go', 'gomod',
            'html',
            'javascript',
            'json', 'yaml',
            'latex',
            'php',
        },
        highlight = {
            enable = true,
            disable = {},
        },
        indent = {
            enable = {'hcl'},
        },
    }

    require('ts_context_commentstring').setup {}
end

return M
