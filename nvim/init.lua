vim.cmd('set nu ai et sts=4 sw=4 ts=4 tw=78 cursorline encoding=utf8')
vim.cmd('set pastetoggle=<F9>')

vim.g.mapleader = ' '

-- restore cursor position when opening files.
vim.cmd([[
    autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif 
]])

function _G.put(...)
    local objects = {}
    for i = 1, select('#', ...) do
        local v = select(i, ...)
        table.insert(objects, vim.inspect(v))
    end

    print(table.concat(objects, '\n'))
    return ...
end

require('plugins').init()
