local cmpCapabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").clangd.setup({
    cmd = {'clangd-12'},
    capabilities = cmpCapabilities
})
