local neodev = require("neodev")
neodev.setup()

local config = require("lspconfig")

local cmpCapabilities = require("cmp_nvim_lsp").default_capabilities()


config.ccls.setup({
    capabilities = cmpCapabilities
})

-- config.clangd.setup({
--     cmd = { "clangd-12" },
--     capabilities = cmpCapabilities
-- })

config.tsserver.setup({
    capabilities = cmpCapabilities
})

config.rust_analyzer.setup({
    capabilities = cmpCapabilities,
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true
            }
        }
    }
})

config.pylsp.setup({
    capabilities = cmpCapabilities
})

config.lua_ls.setup({
  capabilities = cmpCapabilities,
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
vim.keymap.set("n", "<leader>df", vim.lsp.buf.code_action);
