local neodev = require("neodev")
neodev.setup()

require("hover").setup {
    init = function()
        -- Require providers
        require("hover.providers.lsp")
        -- require('hover.providers.gh')
        -- require('hover.providers.gh_user')
        -- require('hover.providers.jira')
        require('hover.providers.dap')
        -- require('hover.providers.fold_preview')
        -- require('hover.providers.diagnostic')
        -- require('hover.providers.man')
        -- require('hover.providers.dictionary')
        -- require('hover.providers.highlight')
    end,
    preview_opts = {
        border = 'single'
    },
    -- Whether the contents of a currently open hover window should be moved
    -- to a :h preview-window when pressing the hover keymap.
    preview_window = false,
    title = true,
    mouse_providers = { }, mouse_delay = 1000
}

vim.keymap.set("n", "K", require("hover").hover, {desc = "hover.nvim"})
vim.keymap.set("n", "<leader>si", require("hover").hover, {desc = "hover.nvim"})
vim.keymap.set("n", "gK", require("hover").hover_select, {desc = "hover.nvim (select)"})
vim.keymap.set("n", "<C-p>", function() require("hover").hover_switch("previous") end, {desc = "hover.nvim (previous source)"})
vim.keymap.set("n", "<C-n>", function() require("hover").hover_switch("next") end, {desc = "hover.nvim (next source)"})

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
    local client = get_client_by_name(0, "ts_ls");
    if client == nil then
        vim.print("goToSourceDefinition requires a ts_ls lsp active");
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

config.ts_ls.setup({
    capabilities = cmpCapabilities,
    cmd = { "bash", "-c", "tee /home/pdoud/lsptest/inlsp.log | npx typescript-language-server --stdio | tee /home/pdoud/lsptest/outlsp.log" },

    -- Sometimes for some reason my setup passes 'javascript' for filetype into this
    -- for a '.ts' file, causing errors about types in a non-ts file. Overriding this
    -- to trust the file name to work around as I am not sure where the filetype gets 
    -- set to 'typescript'. I believe nvim is detecting javascript and something 
    -- should be overwriting it to typescript later but I do not know where that is
    -- done. 
    -- TODO - solve this permanently. Probably a plugin somewhere. I kinda suspect 
    -- doge
    get_language_id = function(bufnr, filetype)
        local name = vim.fn.expand("#" .. bufnr .. ":e");
        if name == "ts" then
            return 'typescript'
        elseif name == "tsx" then
            return 'typescriptreact'
        end

        return filetype;
    end
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
vim.keymap.set("n", "<leader>su", vim.lsp.buf.references);
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action);
vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float);
vim.keymap.set("n", "<leader>df", vim.lsp.buf.code_action);
