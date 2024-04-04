local neodev = require("neodev")
neodev.setup()

local config = require("lspconfig")

local cmpCapabilities = require("cmp_nvim_lsp").default_capabilities()


-- config.ccls.setup({
--     capabilities = cmpCapabilities
-- })

config.clangd.setup({
    cmd = { "clangd-16" },
    capabilities = cmpCapabilities
})

config.tsserver.setup({
    capabilities = cmpCapabilities,
    cmd = { "npx", "typescript-language-server", "--stdio" },
    
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

local htmlCapabilities = require("cmp_nvim_lsp").default_capabilities()
htmlCapabilities.textDocument.completion.completionItem.snippetSupport = true
config.html.setup({
    capabilities = htmlCapabilities
})
config.emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = htmlCapabilities,
    filetypes = { "eruby", "html", "javascriptreact", "less", "svelte", "pug", "typescriptreact", "vue" },
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ["bem.enabled"] = true,
        },
      },
    }
})

vim.keymap.set("n", "<leader>sr", vim.lsp.buf.rename);
vim.keymap.set("n", "<leader>si", vim.lsp.buf.hover);
vim.keymap.set("n", "<leader>su", vim.lsp.buf.references);
vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float);
vim.keymap.set("n", "<leader>df", vim.lsp.buf.code_action);
