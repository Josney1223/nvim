print(_VERSION)
print("NVIM Version " .. vim.version().major .. "." .. vim.version().minor .. "." .. vim.version().patch)
require("mynvim.remap")
require("mynvim.packer")
require("mynvim.set")

print("Bem vindo")
