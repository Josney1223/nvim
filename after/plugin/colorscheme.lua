local themeName = ""
vim.o.background = "dark"

if _G['escolha'] == "2" then
    themeName = 'everforest'
else
    themeName = 'rose-pine'
end

require(themeName).setup({ transparent = true })

vim.cmd("colorscheme " .. themeName)
print("Tema atual:", themeName)
