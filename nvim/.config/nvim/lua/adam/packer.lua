return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	use("neovim/nvim-lspconfig")
	use({ "williamboman/mason.nvim" })
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/playground")
	use("thehamsta/nvim-dap-virtual-text")
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})
	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
		},
	})
	use("mfussenegger/nvim-jdtls")

	use("windwp/nvim-projectconfig")

	use("mfussenegger/nvim-dap")
	use("leoluz/nvim-dap-go")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	use({
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/vim-vsnip",
		"hrsh7th/cmp-nvim-lsp-signature-help",
	})

	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		-- commit = "a0cd6ccd73f0cc1d17bfb8be4c39a1dccd5ff757",
		config = function()
			require("gitsigns").setup()
		end,
	})

	use("lukas-reineke/indent-blankline.nvim")
	use("mattn/emmet-vim")

	use({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		tag = "nightly",
	})

	use({
		"nvim-telescope/telescope.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	use({ "ellisonleao/gruvbox.nvim" })
	use({ "folke/tokyonight.nvim" })

	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use("nvim-lua/lsp-status.nvim")
	use("github/copilot.vim")
	use("voldikss/vim-floaterm")
	use("numToStr/Comment.nvim")
end)
