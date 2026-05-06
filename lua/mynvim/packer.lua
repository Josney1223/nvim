-- on windows install choco, with choco install ripgrep and fd

require('lazy').setup({
    {
        "f-person/git-blame.nvim",
        -- load the plugin at startup
        event = "VeryLazy",
        -- Because of the keys part, you will be lazy loading this plugin.
        -- The plugin will only load once one of the keys is used.
        -- If you want to load the plugin at startup, add something like event = "VeryLazy",
        -- or lazy = false. One of both options will work.
        opts = {
            -- your configuration comes here
            -- for example
            enabled = true, -- if you want to enable the plugin
            message_template = " -> <summary> • <date> • <author> ", -- template for the blame message, check the Message template section for more options
            date_format = "%d-%m-%Y", -- template for the date, check Date format section for more options
            virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
        },

    },
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
