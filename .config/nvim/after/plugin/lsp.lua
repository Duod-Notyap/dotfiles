local neodev = require("neodev")
neodev.setup()

local config = require("lspconfig")
local cmpCapabilities = require("cmp_nvim_lsp").default_capabilities()

local extraCommands = {
    findSourceDefinition = "textDocument/findSourceDefinition"
}

local handlers = { }
handlers[extraCommands.findSourceDefinition] = vim.lsp.handlers["textDocument/definition"];

local function jump_to_file_location(file, location)
    vim.cmd.edit(file)
    vim.lsp.util.jump_to_location(location);
end

local function get_client_by_name(bufnr, name)
    local clients = vim.lsp.get_clients({bufnr});
    for _, client in ipairs(clients) do
        if client.name == name then
            return client;
        end
    end

    return nil;
end

local function go_to_source_implementation()
    local client = get_client_by_name(0, "tsserver");
    if client == nil then
        vim.print("goToSourceDefinition requires a tsserver lsp active");
        return;
    end

    local pos = vim.lsp.util.make_position_params(0);
    vim.print(client.handlers)
    client.request(
        "workspace/executeCommand",
        {
            command = "_typescript.goToSourceDefinition",
            arguments = {pos.textDocument.uri, pos.position}
        },
        vim.lsp.handlers["textDocument/definition"], 0)
end

vim.keymap.set("n", "<leader>gs", go_to_source_implementation);

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client ~= nil then
            for k,v in ipairs(extraCommands) do
                if client.supports_method(v) then
                    client.handlers[v] = handlers[v];
                end
            end
        end
    end
})


vim.diagnostic.config({
    update_in_insert = true
})

-- config.ccls.setup({
--     capabilities = cmpCapabilities
-- })

config.clangd.setup({
    cmd = { "clangd-18" },
    capabilities = cmpCapabilities
})

config.tsserver.setup({
    capabilities = cmpCapabilities,
    cmd = { "npx", "typescript-language-server", "--stdio" }
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

config.somesass_ls.setup({})

local htmlCapabilities = require("cmp_nvim_lsp").default_capabilities()
htmlCapabilities.textDocument.completion.completionItem.snippetSupport = true
config.html.setup({
    capabilities = htmlCapabilities
})
config.emmet_ls.setup({
    -- on_attach = on_attach,
    capabilities = htmlCapabilities,
    filetypes = { "eruby", "html", "javascriptreact", "less", "svelte", "pug", "typescriptreact", "vue", "mason", "ejs" },
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
