local function config()
    vim.g.goimports_simplify = true
    vim.g.goimports_show_loclist = false -- don't show location list for errors; we have lsp for that
    vim.g.goimports_local = 'go.classmarkets.com' -- comma-separated list
end

return {
	config = config
}
