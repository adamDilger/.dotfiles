return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use 'neovim/nvim-lspconfig'
	use { "williamboman/mason.nvim" }
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	use {
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-cmdline',
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-vsnip',
		'hrsh7th/vim-vsnip'
	}

	use {
		'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
		config = function() require('gitsigns').setup() end
	}

	use {
		'kyazdani42/nvim-tree.lua',
		requires = { 'kyazdani42/nvim-web-devicons' },
		tag = 'nightly'
	}

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use { "ellisonleao/gruvbox.nvim" }
end)
