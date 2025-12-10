-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer
    use 'wbthomason/packer.nvim'

    --lsp
    use 'folke/neodev.nvim'
    use 'mfussenegger/nvim-dap'
    use 'neovim/nvim-lspconfig'
    use 'rcarriga/nvim-dap-ui'

    --theming
    use '0xstepit/flow.nvim'
    use 'aktersnurra/no-clown-fiesta.nvim'
    use 'loctvl842/monokai-pro.nvim'
    use 'sainnhe/everforest'
    use 'startup-nvim/startup.nvim'
    use 'tyrannicaltoucan/vim-deep-space'
    use 'vim-airline/vim-airline'
    use 'vim-scripts/ego.vim'
    use 'water-sucks/darkrose.nvim'

    --cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/nvim-cmp'
    use { "L3MON4D3/LuaSnip", tag = "v2.*", run = "make install_jsregexp" }
    use { 'saadparwaiz1/cmp_luasnip' }
    use "rafamadriz/friendly-snippets"


    --File management
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.4', requires = { {'nvim-lua/plenary.nvim'} } }
    use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons', } }
    use 'nvim-tree/nvim-web-devicons'
    use { 'ThePrimeagen/harpoon', branch = "harpoon2", requires = { {"nvim-lua/plenary.nvim"} } }

    --Highlighting
    use { 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim', as = 'rainbow-delimiters.nvim' }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    use { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" }

    -- misc
    use 'airblade/vim-gitgutter'
    use { 'kkoomen/vim-doge', run = ":call doge#install()" } --This one isnt that great.
    use 'lewis6991/hover.nvim'
    use 'mbbill/undotree'
    use 'mg979/vim-visual-multi'
    use { 'OXY2DEV/markview.nvim', tag = "v25.5.4" }
    use 'svermeulen/vim-subversive'
    use 'svermeulen/vim-yoink'
    use 'kylechui/nvim-surround'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use { "windwp/nvim-autopairs", event = "InsertEnter", config = function() require("nvim-autopairs").setup {} end }
    use 'konfekt/vim-formatprgs'

    -- nvim scripting libraries
    use 'nvim-neotest/nvim-nio'

end)
