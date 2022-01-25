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

    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    require('local/goimports').init(packer)
    require('local/telescope').init(packer)
    require('local/lsp').init(packer)
    require('local/lualine').init(packer)
    require('local/treesitter').init(packer)
    require('local/theme').init(packer)

    use 'axelf4/vim-strip-trailing-whitespace'
    use 'AndrewRadev/linediff.vim'
    use 'tpope/vim-commentary'

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
