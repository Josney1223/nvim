# NVIM CONFIG

## Requirements
- Neovim 0.10+

On linux install `ripgrep`
On windows install choco via powershell admin, then `choco install ripgrep` and `choco install fd`

## Folder
Put the directory or git clone on one of the folders below:
### Linux
`home/{user}/.config/nvim`, maybe it's necessary creating a nvim folder.
### Windows
`{user}/AppData/Local/nvim`

## For LSP
### Lua (lua_ls)
For NVIM
### Golang (Gopls)
Needs Go installed
### Python (pylsp)
Needs Python3 installed
### JS (ts_ls, eslint, svelte)
Needs Node 20+ installed(i think this is the minimum version) 
### Tailwind CSS (tailwindcss)
Needs Node 20+ installed(i think this is the minimum version) 

## Installed Plugins and Major Commands
- Leader command: ` `
- Telescope & complimentary (Moving between files)
    - `<leader>pv` go to project view
    - `<leader>pf` go to project find files
    - `<leader>ps` go to find words in project
- Fugitive (Git integration)
    - `:G` and complement with git command
- Harpoon (Changing between chosen files) 
    - `<C-e>` window with all files 
    - `<leader>a` adding file to harpoon
- Terminal (Opening terminal inside nvim)
    - `<leader>t` open and close terminal
- Undotree (Nice Undotree) 
    - `<leader>u` open and close undotree 
    - `<C-w>` change between windows
- lsp_zero (Using LSP)
    - `:LspRestart` restart LSP (sometimes is needed)
- Mason & complimentary (Managing LSPs)
    - `:Mason` open Mason window for LSP
- Treesitter (For hightlighting in languages) 
- Todo (For taking notes of things to remember later) 
    - `<leader>pt` window for all todos
- Flog (For seeing GitGraph) 
    - `<leader>gg` open window gitgraph

## Themes
- Nightfox
    - `:ThemeNightfox`
- Yorumi
    - `:ThemeYorumi`
- Melange
    - `:ThemeMelange`
