local current_time = os.date("*t")

if current_time.hour >= 18 and current_time.hour < 22 then
    vim.cmd([[colorscheme nightfox]])
elseif current_time.hour >= 22 and current_time.hour < 6 then
    vim.cmd([[colorscheme yorumi]])
else
    vim.cmd([[colorscheme gruvbox]])
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
    'ThemeGruvbox',
    function()
        vim.cmd('colorscheme gruvbox')
    end,
    { bang = true, desc = 'gruvbox theme' }
)
