vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
  -- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }}

  use({
	  'rose-pine/nvim',
	  as = 'rose-pine',
	  config = function()
		  vim.cmd('colorscheme rose-pine')
	  end
  })
  use "mbbill/undotree"
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})
  use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!
  use {
	  "ThePrimeagen/harpoon",
	  branch = "harpoon2",
	  requires = { {"nvim-lua/plenary.nvim"} }
  }
  use({'VonHeikemen/lsp-zero.nvim', branch = 'v4.x'})
  use {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim","neovim/nvim-lspconfig",}
  use({'neovim/nvim-lspconfig'})
  use({'hrsh7th/nvim-cmp'})
  use({'hrsh7th/cmp-nvim-lsp'})
end)
