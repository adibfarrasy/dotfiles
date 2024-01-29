-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Theme
    use 'ellisonleao/gruvbox.nvim'

    -- Commenting
    use 'tpope/vim-commentary'

    --  Auto-pair brackets
    use 'jiangmiao/auto-pairs'

    --  Inline git blame
    use 'APZelos/blamer.nvim'

    -- Status line
    use 'nvim-lualine/lualine.nvim'

    --  Git wrapper
    use 'tpope/vim-fugitive'

    --  Fuzzy finder
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/popup.nvim' } }
    }


    --  Dev icons
    use 'kyazdani42/nvim-web-devicons'

    --  LSP
    use 'neovim/nvim-lspconfig'

    --  Autocomplete
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'alvan/vim-closetag'

    --  Debugging
    use 'mfussenegger/nvim-dap'
    use 'leoluz/nvim-dap-go'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'nvim-telescope/telescope-dap.nvim'

    --  Tree-sitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    --  Vim tutorial
    use 'ThePrimeagen/vim-be-good'

    --  Markdown preview
    use { 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install' }

    --  Color highlight
    use 'NvChad/nvim-colorizer.lua'

    -- File explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = { 'nvim-tree/nvim-web-devicons' },
    }
end)
