-- Mappings for the terminal panes (using the neovim specific t namespace).

-- Make Escape enter normal mode.
vim.cmd [[ tnoremap <Esc> <C-\><C-n> ]]

-- Make the usual buffer navigation work directly, without acrobatics.
vim.cmd [[ tnoremap <C-w>l <C-\><C-N><C-w>l ]]
vim.cmd [[ tnoremap <C-w>h <C-\><C-N><C-w>h ]]
vim.cmd [[ tnoremap <C-w>k <C-\><C-N><C-w>k ]]
vim.cmd [[ tnoremap <C-w>j <C-\><C-N><C-w>j ]]

-- When switching to terminal buffer, enter insert mode.
vim.cmd [[ autocmd BufEnter term://* startinsert ]]
