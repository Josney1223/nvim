-- on windows install choco, with choco install ripgrep and fd

require('lazy').setup({
    {
        'nvim-telescope/telescope.nvim',
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
        lazy = false,
        priority = 1000,
        build = ':TSUpdate',
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
    'folke/todo-comments.nvim',
    'isakbm/gitgraph.nvim',
    'numToStr/Comment.nvim',
    {
        'mistweaverco/kulala.nvim',
        ft = { "http", "rest" },
        opts = {
            global_keymaps = false,
            global_keymaps_prefix = "<leader>",
            kulala_keymaps_prefix = ""
        }
    },
    {
        "christoomey/vim-tmux-navigator",
        lazy = false
    },

})
