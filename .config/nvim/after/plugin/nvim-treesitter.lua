vim.g['rainbow-delimiters'] = {
    enable = true,
    query = 'rainbow-delimiters',
    strategy = require("rainbow-delimiters").strategy.global,
    blacklist = { "md" }
}


require("nvim-treesitter.configs").setup({
    ignore_install = {},
    modules = {},
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
            },
            selection_modes = {
                ['@parameter.outer'] = 'v',
                ['@function.outer'] = 'V',
                ['@class.outer'] = '<c-v>',
            },
            include_surrounding_whitespace = false
        },
    },
    ensure_installed = { "rust", "cpp", "c", "javascript", "typescript", "lua", "vim", "vimdoc" },
    sync_install = true,
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
})

require('nvim-treesitter.install').update({ with_sync = true })()

local parsers = require("nvim-treesitter.parsers")
parsers.kpl = {
    tier = 2,
    install_info = {
        revision = "213456789abcdef",
        url = "~/dev/tree-sitter-kpl",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
        generate_requires_npm = false,
        requires_generate_from_grammar = false
    },
    filetype="kpl"
}
