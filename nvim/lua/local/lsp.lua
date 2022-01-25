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

function on_attach(client, bufnr)
    -- Always show the sign column on the far left so the view doesn't bounce
    -- around as LSP annotations come and go.
    vim.cmd('set signcolumn=yes')

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...)

    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    --buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>ne', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
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
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
            ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'path' },
            {
                name = 'buffer',
                option = {
                    get_bufnrs = vim.api.nvim_list_bufs, -- search all buffers
                },
            },
        }),
    }

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
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 1000, -- milliseconds
            },
        }
    end

    lspconfig.ansiblels.setup { -- npm i -g ansible-language-server
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ansibleLint = {
                enabled = false,
            },
        },
    }

    lspconfig.phpactor.setup { -- https://phpactor.readthedocs.io/en/master/usage/standalone.html#global-installation
        on_attach = on_attach,
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
