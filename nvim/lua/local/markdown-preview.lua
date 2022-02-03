local M = {}

M.init = function(packer)
    packer.use {
        'iamcco/markdown-preview.nvim',
        run = M.run,
        ft = {'markdown'},
    }
end

M.run = function()
    vim.fn['mkdp#util#install']()
end

return M
