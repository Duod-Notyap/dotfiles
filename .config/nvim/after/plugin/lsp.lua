local neodev = require("neodev")
neodev.setup()

require("hover").config {
    providers = {
        require("hover.providers.lsp"),
        require('hover.providers.dap')
        -- require('hover.providers.gh')
        -- require('hover.providers.gh_user')
        -- require('hover.providers.jira')
        -- require('hover.providers.fold_preview')
        -- require('hover.providers.diagnostic')
        -- require('hover.providers.man')
        -- require('hover.providers.dictionary')
        -- require('hover.providers.highlight')
    },
    preview_opts = {
        border = 'single'
    },
    -- Whether the contents of a currently open hover window should be moved
    -- to a :h preview-window when pressing the hover keymap.
    preview_window = false,
    title = true,
    mouse_providers = { }, mouse_delay = 1000
}

local extraCommands = {
    findSourceDefinition = "textDocument/findSourceDefinition"
}

local handlers = { }
handlers[extraCommands.findSourceDefinition] = vim.lsp.handlers["textDocument/definition"];

local function get_client_by_name(bufnr, name)
    local clients = vim.lsp.get_clients({bufnr});
    for _, client in ipairs(clients) do
        if client.name == name then
            return client;
        end
    end

    return nil;
end


-- ts_ls custom implementation to go to source code not definition.
local function go_to_source_implementation()
    local client = get_client_by_name(0, "ts_ls");
    if client == nil then
        vim.print("goToSourceDefinition requires a ts_ls lsp active");
        return;
    end

    local pos = vim.lsp.util.make_position_params(0, 'utf-8');
    vim.print(client.handlers)
    client.request(
        "workspace/executeCommand",
        {
            command = "_typescript.goToSourceDefinition",
            arguments = {pos.textDocument.uri, pos.position}
        },
        vim.lsp.handlers["textDocument/definition"], 0)
end


vim.diagnostic.config({ update_in_insert = true })

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

        --Keybinds
        vim.keymap.set("n", "K", require("hover").open, {desc = "hover.nvim"})
        vim.keymap.set("n", "gK", require("hover").select, {desc = "hover.nvim (select)"})
        vim.keymap.set("n", "<C-p>", function() require("hover").switch("previous") end, {desc = "hover.nvim (previous source)"})
        vim.keymap.set("n", "<C-n>", function() require("hover").switch("next") end, {desc = "hover.nvim (next source)"})
        vim.keymap.set("n", "<leader>sr", vim.lsp.buf.rename);
        vim.keymap.set("n", "<leader>su", vim.lsp.buf.references);
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action);
        vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float);
        vim.keymap.set("n", "<leader>df", vim.lsp.buf.code_action);
        vim.keymap.set("n", "<leader>gs", go_to_source_implementation);
    end
})

local cmpCapabilities = require("cmp_nvim_lsp").default_capabilities()


vim.lsp.config.clangd = {
    cmd = { "clangd-21" },
    capabilities = cmpCapabilities
}
vim.lsp.enable('clangd')


vim.lsp.config.ts_ls = {
    capabilities = cmpCapabilities,
    cmd = { "npx", "typescript-language-server", "--stdio" },

    -- Sometimes for some reason my setup passes 'javascript' for filetype into this
    -- for a '.ts' file, causing errors about types in a non-ts file. Overriding this
    -- to trust the file name to work around as I am not sure where the filetype gets 
    -- set to 'typescript'. I believe nvim is detecting javascript and something 
    -- should be overwriting it to typescript later but I do not know where that is
    -- done. 
    -- TODO - solve this permanently. Probably a plugin somewhere. I kinda suspect doge
    get_language_id = function(bufnr, filetype)
        local name = vim.fn.expand("#" .. bufnr .. ":e");
        if name == "ts" then
            return 'typescript'
        elseif name == "tsx" then
            return 'typescriptreact'
        end

        return filetype;
    end
}
vim.lsp.enable('ts_ls')


vim.lsp.config.rust_analyzer = {
    capabilities = cmpCapabilities,
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true
            }
        }
    }
}
vim.lsp.enable('rust_analyzer')


vim.lsp.config.gopls = {
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    }
}
vim.lsp.enable('gopls')


vim.lsp.config.pylsp = {
    capabilities = cmpCapabilities
}
vim.lsp.enable('pylsp')


vim.lsp.config.lua_ls = {
    capabilities = cmpCapabilities,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT"
            }
        }
    }
}
vim.lsp.enable('lua_ls')


vim.lsp.config.somesass_ls = {}
vim.lsp.enable('somesass_ls')

-- HTML LSP's

local htmlCapabilities = require("cmp_nvim_lsp").default_capabilities()
htmlCapabilities.textDocument.completion.completionItem.snippetSupport = true


vim.lsp.config.html = { capabilities = htmlCapabilities }
vim.lsp.enable('html')


vim.lsp.config.emmet_language_server = {
    filetypes = { "mason", "eruby", "html", "javascriptreact", "pug", "typescriptreact" },
    init_options = {
        includeLanguages = {},
        excludeLanguages = {},
        extensionsPath = {},
        preferences = {},
        showAbbreviationSuggestions = true,
        showExpandedAbbreviation = "always",
        showSuggestionsAsSnippets = false,
        syntaxProfiles = {},
        variables = {},
    },
}
vim.lsp.enable('emmet_language_server')
