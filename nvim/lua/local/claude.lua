local M = {
    'avifenesh/claucode.nvim',
}

M.cond = function()
    xs, _ =vim.fs.find({ '.claude-enabled' }, { upward = true })
    return #xs > 0
end

M.config = function()
    require("claucode").setup({

        -- Enable default keymaps
        keymaps = {
            enable = true,
            prefix = "<leader>ai",  -- AI prefix to avoid conflicts
        },

        -- Auto-start file watcher on setup
        auto_start_watcher = true,

        -- File watcher settings
        watcher = {
            debounce = 100,  -- milliseconds
            ignore_patterns = { "%.git/", "node_modules/", "%.swp$", "%.swo$" },
        },

        -- Bridge settings
        bridge = {
            timeout = 30000,     -- milliseconds
            max_output = 1048576, -- 1MB
            show_diff = true,   -- Enable diff preview (requires MCP, default: false)
        },

        -- MCP settings
        mcp = {
            enabled = true,         -- Enable MCP server (default: true)
            auto_build = true,      -- Auto-build MCP server if not found (default: true)
            cleanup_on_exit = true, -- Remove MCP server when Neovim exits (default: true)
        },

        -- UI settings
        ui = {
            diff = {
                width = 0.8,
                height = 0.8,
                border = "rounded",
            },
            terminal = {
                height = 0.5, -- Terminal height as fraction of screen (0.5 = 50%)
            },
            icons = {
                enabled = false, -- Set to false to disable icons/emojis
            },
        },

        -- Notification settings
        notifications = {
            silent_watcher = true,    -- Don't notify on watcher start/stop
            silent_claude_md = true,  -- Don't notify on CLAUDE.md updates
        },
    })
end

return M
