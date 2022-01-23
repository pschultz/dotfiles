local M = {}

function M.init(packer)
    packer.use {
        'neovim/nvim-lspconfig',
        config = M.config,
        requires = {
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
        },
    }
end

function lsp_map_keys(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...)
    
    -- Enable completion triggered by <c-x><c-o>
    --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

function M.config()
    -- https://github.com/hrsh7th/nvim-cmp#setup
    local cmp = require('cmp')
    local i = 0
    cmp.setup {
        completion = {
            autocomplete = false, -- require key press for completion
        },
        mapping = {
            ['<C-n>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    cmp.complete()
                end
            end, { 'i', 'c' }),
            ['<C-p>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    cmp.complete()
                end
            end, { 'i', 'c' }),
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'buffer' },
            { name = 'path' },
        }),
    }

    cmp.setup.cmdline(':', {
        sources = {
            { name = 'cmdline' },
            { name = 'path' },
        },
    })
    cmp.setup.cmdline('/', {
        sources = {
            { name = 'buffer' },
        },
    })

    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    local servers = {
        'gopls',  -- go install golang.org/x/tools/gopls@latest
        'bashls', -- npm i -g bash-language-server
        'elmls',  -- npm install -g elm elm-test elm-format @elm-tooling/elm-language-server
        'ltex',   -- https://github.com/valentjn/ltex-ls/releases

        -- npm i -g vscode-langservers-extracted
        'cssls',
        'html',
        'jsonls',
        'eslint',
    }

    local lspconfig = require('lspconfig')
    for _, key in pairs(servers) do
        lspconfig[key].setup {
            on_attach = lsp_map_keys,
            capabilities = capabilities,
        }
    end

    lspconfig.phpactor.setup { -- https://phpactor.readthedocs.io/en/master/usage/standalone.html#global-installation
        on_attach = lsp_map_keys,
        capabilities = capabilities,
        cmd = {
            -- make sure we're loading the least amount of extensions necessary,
            -- for performance. XDebug is especially bad. It sucks that this
            -- also disables any and all security settings such as
            -- disallowed_functions and veiled paths, but since PHP doesn't have
            -- a flag for 'disable extension xyz' there's not much we can do.
            'php', '-n',
            '-d', 'extension=json.so',
            '-d', 'extension=phar.so',
            '-d', 'extension=iconv.so',
            '-d', 'extension=tokenizer.so',
            '/home/pschultz/bin/phpactor/bin/phpactor', 'language-server',
        },
    }
end

return M
