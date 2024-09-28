local current_time = os.date("*t")

if current_time.hour < 18 and current_time > 6 then
    vim.cmd([[colorscheme nightfox]])
else
    vim.cmd([[colorscheme yorumi]])
end

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
