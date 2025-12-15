return {
    -- Packer
    'wbthomason/packer.nvim',

    --lsp
    'mfussenegger/nvim-dap',
    'neovim/nvim-lspconfig',
    'rcarriga/nvim-dap-ui',
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                "lazy.nvim",
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                "LazyVim",
            },
            enabled = function(_)
                return vim.g.lazydev_enabled == nil and true or vim.g.lazydev_enabled
            end,
        }
    },

    --theming
    '0xstepit/flow.nvim',
    'aktersnurra/no-clown-fiesta.nvim',
    'loctvl842/monokai-pro.nvim',
    'sainnhe/everforest',
    'startup-nvim/startup.nvim',
    'tyrannicaltoucan/vim-deep-space',
    'vim-airline/vim-airline',
    'vim-scripts/ego.vim',
    'water-sucks/darkrose.nvim',

    --cmp
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/vim-vsnip',
    'hrsh7th/vim-vsnip-integ',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/nvim-cmp',
    { "L3MON4D3/LuaSnip", tag = "v2.4.1", run = "make install_jsregexp" },
    { 'saadparwaiz1/cmp_luasnip' },
    "rafamadriz/friendly-snippets",


    --File management
    { 'nvim-telescope/telescope.nvim', tag = '0.1.4', requires = { {'nvim-lua/plenary.nvim'} } },
    { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons', } },
    'nvim-tree/nvim-web-devicons',
    { 'ThePrimeagen/harpoon', branch = "harpoon2", requires = { {"nvim-lua/plenary.nvim"} } },

    --Highlighting,
    { 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim', as = 'rainbow-delimiters.nvim' },
    {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        opts = {
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
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true }
        }
    },
    { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },

    -- misc
    'airblade/vim-gitgutter',
    { 'kkoomen/vim-doge', run = ":call doge#install()" },
    'lewis6991/hover.nvim',
    'mbbill/undotree',
    'mg979/vim-visual-multi',
    { 'OXY2DEV/markview.nvim', tag = "v25.5.4" },
    'svermeulen/vim-subversive',
    'svermeulen/vim-yoink',
    'kylechui/nvim-surround',
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    { "windwp/nvim-autopairs", event = "InsertEnter", config = function() require("nvim-autopairs").setup {} end },
    'konfekt/vim-formatprgs',

    -- nvim scripting libraries
    'nvim-neotest/nvim-nio'
}
