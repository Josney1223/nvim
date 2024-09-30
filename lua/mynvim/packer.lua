-- on windows install choco, with choco install ripgrep and fd

require('lazy').setup({
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.8',
        -- or                            , branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim', 'BurntSushi/ripgrep' } }
    },
    {
        'EdenEast/nightfox.nvim',
        priority = 1000,
        lazy = false
    },
    {
        'yorumicolors/yorumi.nvim',
        priority = 1000,
        lazy = false
    },
    {
        'morhetz/gruvbox',
        priority = 1000,
        lazy = false
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
        dependencies = { { "nvim-lua/plenary.nvim" } }
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
    'tpope/vim-fugitive',
    'folke/todo-comments.nvim',
    {
        "rbong/vim-flog",
        lazy = true,
        cmd = { "Flog", "Flogsplit", "Floggit" },
        dependencies = {
            "tpope/vim-fugitive",
        },
    },
})
