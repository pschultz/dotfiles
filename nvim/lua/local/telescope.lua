local M = {}

M.init = function(packer)
    packer.use {
        'nvim-telescope/telescope.nvim', -- status line
        requires = {
            { 'nvim-lua/plenary.nvim' },
        },
        config = M.config
    }
end

M.config = function()
    vim.cmd[[nnoremap ff <cmd>Telescope find_files<cr>]]
    vim.cmd[[nnoremap ag <cmd>Telescope live_grep<cr>]]
    vim.cmd[[nnoremap fb <cmd>Telescope buffers<cr>]]
end

return M
