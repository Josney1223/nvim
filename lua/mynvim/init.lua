print(_VERSION)
print("NVIM Version " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch)

escolha = vim.fn.input("Está utilizando para código(1) ou escrita(2)?")
print("\n")

if escolha == "2" then
    require("mynvim.remap")
    require("mynvim.packer_writing")
    require("mynvim.set")
else
    require("mynvim.remap")
    require("mynvim.packer")
    require("mynvim.set")
end
print("Bem vindo")
