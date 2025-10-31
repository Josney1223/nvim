# NVIM CONFIG

Use with Tmux and Kyed for better programming experience:
- [Kyed](https://github.com/rvaiya/keyd)
    - For Caps lock become useful as ctrl + esc
- [Tmux](https://github.com/Josney1223/tmux)

## Requirements
- Neovim 0.10+
### Linux
On linux install `ripgrep` and `luarocks` and a clipboard manager (`xsel`)
If Ubuntu use snap store for ripgrep and apt for luarocks
### Windows
On windows install choco via powershell admin, then 
 - `choco install ripgrep` 
 - `choco install fd`
 - `choco install zig`
 - `choco install luarocks`

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
If Ubuntu use snap store
### Python (pylsp)
Needs Python3 installed
### JS (ts_ls, eslint, svelte)
Needs Node 20+ installed(i think this is the minimum version) 
If Ubuntu install npm and with npm install node. 
### Tailwind CSS (tailwindcss)
Needs Node 20+ installed(i think this is the minimum version) 
If Ubuntu install npm and with npm install node. 

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
    - `<leader>h` go to file 1 
    - `<leader>j` go to file 2
    - `<leader>k` go to file 3
    - `<leader>l` go to file 4
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
- GitGraph (For seeing GitGraph) 
    - `<leader>gg` open window gitgraph
- Vim Commentary (For commenting group of lines)
    - `gc` coment selection in visual mode

## Themes
- Nightfox
    - `:ThemeNightfox`
- Yorumi
    - `:ThemeYorumi`
- Melange
    - `:ThemeMelange`
