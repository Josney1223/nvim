# NVIM CONFIG

## Requirements
- Neovim 0.10+

On windows install choco via powershell admin, then `choco install ripgrep` and `choco install fd`

## Folder
Put the directory or git clone on one of the folders below:
### Linux
`home/{user}/.config/nvim`, maybe it's necessary creating a nvim folder.
### Windows
`{user}/AppData/Local/nvim`

## For LSP
### Golang (Gopls)
Needs Go installed
### Python (pyright)
Needs Python3 installed
### JS (tsserver, eslint, svelte)
Needs Node 20+ installed(i think this is the minimum version) 

## Theme 
Using the nightfox theme, change it in lua/lessa/packer.lua, inside the `EdenEast/nightfox.nvim`
