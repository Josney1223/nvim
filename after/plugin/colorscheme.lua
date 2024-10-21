local current_time = os.date("*t")
math.randomseed(os.time())

local lightTheme = { "melange" }
local lightDarkTheme = { "nightfox", "kanagawa" }
local darkTheme = { "yorumi" }

local sizeArray = 0
local colorRand = 0
local themeName = ""

if current_time.hour >= 18 and current_time.hour < 22 then
    sizeArray = #lightDarkTheme
    colorRand = math.random(sizeArray)
    themeName = lightDarkTheme[colorRand]

    vim.cmd("colorscheme " .. themeName)
elseif current_time.hour >= 22 or current_time.hour < 6 then
    sizeArray = #darkTheme
    colorRand = math.random(sizeArray)
    themeName = darkTheme[colorRand]

    vim.cmd("colorscheme " .. themeName)
else
    sizeArray = #lightTheme
    colorRand = math.random(sizeArray)
    themeName = lightTheme[colorRand]

    vim.cmd("colorscheme " .. themeName)
end
print("Tema atual:", themeName)

local function createThemeCommand(theme)
    vim.api.nvim_create_user_command(
        'Theme' .. theme,
        function()
            vim.cmd('colorscheme ' .. theme)
        end,
        { bang = true, desc = theme .. ' theme' }
    )
end

for i = 1, #lightTheme, 1 do
    createThemeCommand(lightTheme[i])
end

for i = 1, #lightDarkTheme, 1 do
    createThemeCommand(lightDarkTheme[i])
end

for i = 1, #darkTheme, 1 do
    createThemeCommand(darkTheme[i])
end
