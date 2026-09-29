vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("x", "<leader>pp", "\"_dP")
vim.keymap.set("v", "<leader>yy", '"+y')
vim.keymap.set("v", "<leader>py", '"+p')
vim.keymap.set("n", "<leader>yy", '"+y')
vim.keymap.set("n", "<leader>py", '"+p')
vim.keymap.set("n", "<leader>k", function()
    vim.diagnostic.open_float()
end, { noremap = true, silent = true })

-- Claudinho
vim.keymap.set("n", "<leader>cc", "<cmd>ClaudeCode<cr>")
vim.keymap.set("v", "<leader>ccs", "<cmd>ClaudeCodeSend<cr>")
vim.keymap.set("n", "<leader>ccda", "<cmd>ClaudeCodeDiffAccept<cr>")
vim.keymap.set("n", "<leader>ccdd", "<cmd>ClaudeCodeDiffDeny<cr>")

-- Sobrescrever no Claude
vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], { desc = "Window commands from terminal" })
