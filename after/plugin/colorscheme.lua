local current_time = os.date("*t")

if current_time.hour >= 18 and current_time.hour < 22 then
    vim.cmd([[colorscheme nightfox]])
elseif current_time.hour >= 22 or current_time.hour < 6 then
    vim.cmd([[colorscheme yorumi]])
else
    vim.cmd([[colorscheme melange]])
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

vim.api.nvim_create_user_command(
    'ThemeMelange',
    function()
        vim.cmd('colorscheme melange')
    end,
    { bang = true, desc = 'melange theme' }
)
