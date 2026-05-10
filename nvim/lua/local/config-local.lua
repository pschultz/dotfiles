local M = {
    'klen/nvim-config-local',
}

M.config = function()
    require('config-local').setup {
        config_files = { ".nvim.lua", ".vimrc" },
        silent = false,
        lookup_parents = true,
    }
end

return M

