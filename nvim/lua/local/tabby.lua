local M = {
    'TabbyML/tabby',
}

M.config = function(plugin)
    vim.g.tabby_server_url = 'http://10.201.128.1:80'
    vim.opt.rtp:append(plugin.dir .. '/clients/vim')
end

return M
