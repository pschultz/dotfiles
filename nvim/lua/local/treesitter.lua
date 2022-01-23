local function config()
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

return {
	config = config
}
