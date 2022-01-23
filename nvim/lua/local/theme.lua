local function config()
    -- vim.g.tokyonight_style = 'day'
    -- vim.g.tokyonight_style = 'night'
    vim.g.tokyonight_style = 'storm'
    vim.g.tokyonight_hide_inactive_statusline = true

    -- darker sidebars
    vim.g.tokyonight_sidebars = {'packer', 'terminal'}

    --local colors = require('tokyonight.colors')
    --local c = colors.setup(nil)

    --[[
    vim.g.tokyonight_colors = {
        -- https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/theme.lua
        -- https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors.lua
        CursorLine = { bg = c.bg_highlight }
    }
    --]]

    vim.cmd('set termguicolors')
    vim.cmd('colorscheme tokyonight')

    require('lualine').setup {
        -- https://github.com/nvim-lualine/lualine.nvim#default-configuration
        options = {
            theme = 'tokyonight',
        }
    }
end


return {
	config = config
}
