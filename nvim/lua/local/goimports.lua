local M = {}

M.init = function(packer)
    packer.use {
        'mattn/vim-goimports',
        config = M.config,
    }
end

M.config = function()
    vim.g.goimports_simplify = true
    vim.g.goimports_show_loclist = false -- don't show location list for errors; we have lsp for that
    vim.g.goimports_local = 'go.classmarkets.com' -- comma-separated list
end

return M
