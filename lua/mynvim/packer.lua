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
        'catppuccin/nvim',
        priority = 1000,
        lazy = false
    },
    {
        'neanias/everforest-nvim',
        priority = 1000,
        lazy = false
    },
    {
        'yorumicolors/yorumi.nvim',
        priority = 1000,
        lazy = false
    },
    {
        'rebelot/kanagawa.nvim',
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
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        config = true
    },
    'tpope/vim-fugitive',
    'folke/todo-comments.nvim',
    'isakbm/gitgraph.nvim',
    'numToStr/Comment.nvim',
    {
        "rest-nvim/rest.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "j-hui/fidget.nvim",
            "rest-nvim/tree-sitter-http",
            opts = function(_, opts)
                opts.ensure_installed = opts.ensure_installed or {}
                table.insert(opts.ensure_installed, "http")
            end,
        }
    }
})
