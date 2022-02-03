local M = {}

M.init = function(packer)
    packer.use {
        'nvim-lualine/lualine.nvim', -- status line
        config = M.config
    }
end

M.config = function()
    require('lualine').setup {
        -- https://github.com/nvim-lualine/lualine.nvim#default-configuration
        options = {
            icons_enabled = true, -- requires a patched font; see https://www.nerdfonts.com/font-downloads
        },
        sections = {
            lualine_b = {'branch', 'diagnostics'}, -- no 'diff'
            lualine_c = {
                {
                    'filename',
                    file_status = true,
                    path = 1,
                },
            },
            lualine_y = {}, -- defaults to {'progress'},
        },
    }
end

return M
