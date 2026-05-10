local M = {
    'nvim-telescope/telescope.nvim',
}

M.dependencies = {
    { 'nvim-lua/plenary.nvim' },
}

M.config = function()
    vim.cmd[[nnoremap ff <cmd>Telescope find_files<cr>]]
    vim.cmd[[nnoremap ag <cmd>Telescope live_grep<cr>]]
    vim.cmd[[nnoremap fb <cmd>Telescope buffers<cr>]]
end

return M
