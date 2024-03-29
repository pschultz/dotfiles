local M = {}

M.init = function(packer)
    packer.use {
        'folke/tokyonight.nvim',
        config = M.config
    }
end

M.config = function()
    -- vim.g.tokyonight_style = 'day'
    -- vim.g.tokyonight_style = 'storm'
    vim.g.tokyonight_style = 'night'
    vim.g.tokyonight_hide_inactive_statusline = true

    -- darker sidebars
    vim.g.tokyonight_sidebars = {'packer', 'terminal'}

    vim.cmd('colorscheme tokyonight')

    require('lualine').setup {
        -- https://github.com/nvim-lualine/lualine.nvim#default-configuration
        options = {
            theme = 'tokyonight',
        }
    }
end

return M
