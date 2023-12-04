local config = require("lspconfig")

local cmpCapabilities = require("cmp_nvim_lsp").default_capabilities()

config.clangd.setup({
    cmd = {'clangd-12'},
    capabilities = cmpCapabilities
})

config.tsserver.setup({
    capabilities = capabilities
})

vim.keymap.set("n", "<leader>sr", vim.lsp.buf.rename);
vim.keymap.set("n", "<leader>si", vim.lsp.buf.hover);
