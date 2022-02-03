local M = {}

M.init = function(packer)
    packer.use {
        'sebdah/vim-delve',
        config = M.config
    }
end

M.config = function()
    -- https://github.com/sebdah/vim-delve#configuration
    vim.cmd [[ let g:delve_backend = "native" ]]

    -- https://github.com/sebdah/vim-delve#commands
    vim.cmd [[ autocmd FileType go nnoremap <buffer> <F10> :DlvToggleBreakpoint<CR> ]]
    vim.cmd [[ autocmd FileType go nnoremap <buffer> <F5> :DlvTest<CR> ]]
end

return M
