local M = {}

M.init = function(packer)
    packer.use {
        'nvim-treesitter/nvim-treesitter', -- provides ASTs and syntax highlighting
        run = ':TSUpdate',
        config = M.config,
    }
end

M.config = function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = {
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

        }
    }
end

return M
