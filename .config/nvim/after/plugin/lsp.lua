local neodev = require("neodev")
neodev.setup()

local config = require("lspconfig")

local cmpCapabilities = require("cmp_nvim_lsp").default_capabilities()


config.clangd.setup({
    cmd = {'clangd-12'},
    capabilities = cmpCapabilities
})

config.tsserver.setup({
    capabilities = capabilities
})

config.rust_analyzer.setup({
    capabilities = capabilities,
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true
            }
        }
    }
})

config.pylsp.setup({
    capabilities = capabilities
})

config.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      }
    }
  }
})

vim.keymap.set("n", "<leader>sr", vim.lsp.buf.rename);
vim.keymap.set("n", "<leader>si", vim.lsp.buf.hover);
vim.keymap.set("n", "<leader>su", vim.lsp.buf.references);
vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float);
