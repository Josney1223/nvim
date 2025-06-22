-- on windows install choco, with choco install ripgrep and fd

require('lazy').setup({
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.8',
        -- or                            , branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' } }
    },
    {
        'rose-pine/neovim',
        priority = 1000,
        lazy = false
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
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x'
    },
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
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
