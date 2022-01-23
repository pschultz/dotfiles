local function on_attach(client, bufnr)
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

local function config()
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    local lspconfig = require('lspconfig')

    lspconfig.gopls.setup { on_attach = on_attach } -- go install golang.org/x/tools/gopls@latest
    lspconfig.bashls.setup { on_attach = on_attach } -- npm i -g bash-language-server

    -- npm i -g vscode-langservers-extracted
    lspconfig.cssls.setup { on_attach = on_attach }
    lspconfig.html.setup { on_attach = on_attach }
    lspconfig.jsonls.setup { on_attach = on_attach }
    lspconfig.eslint.setup { on_attach = on_attach }

    lspconfig.elmls.setup { on_attach = on_attach } -- npm install -g elm elm-test elm-format @elm-tooling/elm-language-server
    lspconfig.ltex.setup { on_attach = on_attach } -- https://github.com/valentjn/ltex-ls/releases
    lspconfig.phpactor.setup {
        on_attach = on_attach,
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
    } -- https://phpactor.readthedocs.io/en/master/usage/standalone.html#global-installation
end

return {
	config = config
}
