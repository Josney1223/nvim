vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("v", "<leader>yy", '"+y')
vim.keymap.set("v", "<leader>py", '"+p')
vim.keymap.set("n", "<leader>yy", '"+y')
vim.keymap.set("n", "<leader>py", '"+p')
