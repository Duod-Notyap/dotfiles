require("nvim-treesitter.configs").setup {
    ensure_installed = { "rust", "cpp", "c", "javascript", "typescript", "lua", "vim", "vimdoc" },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true
    }
}
