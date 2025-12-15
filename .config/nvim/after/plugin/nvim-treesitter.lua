vim.g['rainbow-delimiters'] = {
    enable = true,
    query = 'rainbow-delimiters',
    strategy = require("rainbow-delimiters").strategy.global,
    blacklist = { "md" }
}

local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
parser_configs.kpl = {
    install_info = {
        url = "~/dev/tree-sitter-kpl",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
        generate_requires_npm = false,
        requires_generate_from_grammar = false
    },
    filetype="kpl"
}
