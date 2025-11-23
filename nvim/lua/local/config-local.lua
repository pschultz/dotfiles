local M = {}

M.init = function(packer)
    packer.use {
        'klen/nvim-config-local',
        config = M.config
    }
end

M.config = function()
    require('config-local').setup {
        config_files = { ".nvim.lua", ".vimrc" },
        silent = false,
        lookup_parents = true,
    }
end

return M

