vim.cmd([[colorscheme nightfox]])

vim.api.nvim_create_user_command(
    'ThemeNightfox',
    function()
        vim.cmd('colorscheme nightfox')
    end,
    { bang = true, desc = 'nightfox theme' }
)

vim.api.nvim_create_user_command(
    'ThemeYorumi',
    function()
        vim.cmd('colorscheme yorumi')
    end,
    { bang = true, desc = 'yorumi theme' }
)
