-- auto-install packer
local function install_packer()
    local bootstrap = false
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    end

    return bootstrap
end

local packer = nil

local function load_plugins(packer_bootstrap)
    -- run PackerCompile when plugins.lua changes
    vim.cmd([[
      augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
      augroup end
    ]])

    if packer == nil then
        packer = require('packer')
        packer.init()
    end

    local use = packer.use
    packer.reset()

    packer.set_handler('tokyonight_hack', function(plugins, plugin, value)
        put(plugin)
    end)

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'neovim/nvim-lspconfig',
        config = function() require('local/lsp').config() end,
    }

    use {
        'mattn/vim-goimports',
        config = function() require('local/goimports').config() end,
    }

    use {
        'nvim-lualine/lualine.nvim', -- status line
        config = function() require('local/lualine').config() end,
    }

    use {
        'nvim-treesitter/nvim-treesitter', -- provides ASTs and syntax highlighting
        run = ':TSUpdate',
        config = function() require('local/treesitter').config() end,
    }

    use {
        'folke/tokyonight.nvim', -- colorscheme
        config = function() require('local/theme').config() end,
        tokyonight_hack = true,
    }

    use 'AndrewRadev/linediff.vim'

    if packer_bootstrap then
        packer.sync()
    end
end

local function init()
    local bootstrap = install_packer()
    load_plugins(bootstrap)
end

return {
    init = init
}
