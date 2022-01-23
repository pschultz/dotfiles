local function config()
    require('lualine').setup {
        -- https://github.com/nvim-lualine/lualine.nvim#default-configuration
        options = {
            icons_enabled = true, -- requires a patched font; see https://www.nerdfonts.com/font-downloads
        },
        sections = {
            lualine_b = {'branch', 'diagnostics'}, -- no 'diff'
            lualine_y = {}, -- defaults to {'progress'},
        },
    }
end

return {
	config = config
}
