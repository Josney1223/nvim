-- on windows install choco, with choco install ripgrep and fd

require('lazy').setup({
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.8',
        -- or                            , branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' } }
    },
    {
        "neanias/everforest-nvim",
        version = false,
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
    },
    "mbbill/undotree",
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { { "nvim-lua/plenary.nvim" } }
    },
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'tpope/vim-fugitive',
    'isakbm/gitgraph.nvim',
    {
        "christoomey/vim-tmux-navigator",
        lazy = false
    },
    {
        "nvim-neorg/neorg",
        lazy = false,
        version = "*",
        config = function()
            require("neorg").setup {
                load = {
                    ["core.defaults"] = {},
                    ["core.concealer"] = {}
                }
            }
            vim.wo.foldlevel = 99
            vim.wo.conceallevel = 2
        end
    }
})
vim.opt.spelllang = { 'pt_br', 'en' }
vim.opt.spell = true
print("Loaded Neorg")
