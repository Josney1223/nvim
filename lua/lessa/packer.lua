require('lazy').setup({
    {
        'nvim-telescope/telescope.nvim', version= '0.1.8',
        -- or                            , branch = '0.1.x',
        dependencies = { {'nvim-lua/plenary.nvim'} }
    },
    {
        'EdenEast/nightfox.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            vim.cmd([[colorscheme nightfox]])
        end,
    },
    "mbbill/undotree",
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    "nvim-lua/plenary.nvim", -- don't forget to add this one if you don't have it yet!
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { {"nvim-lua/plenary.nvim"} }
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x'
    },
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    },
    'neovim/nvim-lspconfig',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true
    },
})


