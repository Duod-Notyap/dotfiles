vim.g['rainbow-delimiters'] = {
    enable = true,
    query = 'rainbow-delimiters',
    strategy = require("rainbow-delimiters").strategy.global,
    blacklist = { "md" }
}

require("nvim-treesitter.configs").setup {
    ensure_installed = { "rust", "cpp", "c", "javascript", "typescript", "lua", "vim", "vimdoc" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true
    }
}

