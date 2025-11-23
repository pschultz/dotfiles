local M = {}

M.init = function(packer)
    packer.use {
        'TabbyML/tabby', -- status line
        rtp = 'clients/vim',
        config = M.config
    }
end

M.config = function()
    vim.g.tabby_server_url = 'http://10.201.128.1:80'
end

return M
