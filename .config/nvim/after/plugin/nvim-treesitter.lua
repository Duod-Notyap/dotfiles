vim.g['rainbow-delimiters'] = {
    enable = true,
    query = 'rainbow-delimiters',
    strategy = require("rainbow-delimiters").strategy.global,
    blacklist = { "md" }
}

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
