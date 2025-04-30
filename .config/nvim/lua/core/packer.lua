-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'nvim-tree/nvim-web-devicons'

    use 'neovim/nvim-lspconfig'

    use {
        "L3MON4D3/LuaSnip",
        tag = "v2.*", 
        run = "make install_jsregexp"
    }

    use 'airblade/vim-gitgutter'
    use 'tpope/vim-fugitive'

    use 'alvarocz/vim-northpole'
    use {
        'https://gitlab.com/HiPhish/rainbow-delimiters.nvim',
        as = 'rainbow-delimiters.nvim'
    }
    use 'vim-airline/vim-airline'
    use "aktersnurra/no-clown-fiesta.nvim"
    use 'tyrannicaltoucan/vim-deep-space'
    use { 
        'kkoomen/vim-doge',
        run = ":call doge#install()"
    }
    use 'water-sucks/darkrose.nvim'
    use 'folke/neodev.nvim'
    use 'mfussenegger/nvim-dap'
    use 'nvim-neotest/nvim-nio'
    use 'rcarriga/nvim-dap-ui'
    use 'mbbill/undotree'
    use 'easymotion/vim-easymotion'
    use "rafamadriz/friendly-snippets"
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/nvim-cmp'
    use { 'saadparwaiz1/cmp_luasnip' }
    use 'mg979/vim-visual-multi'
    use 'sainnhe/everforest'
    use 'vim-scripts/ego.vim'
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    }

    use "loctvl842/monokai-pro.nvim"

    use '0xstepit/flow.nvim'
    use {
        'OXY2DEV/markview.nvim',
        tag = "v25.5.4"
    }

    use 'tpope/vim-surround'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use "startup-nvim/startup.nvim"

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }   

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    use "lewis6991/hover.nvim"
end)
