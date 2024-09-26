local exitTerm = function()
    vim.cmd(":ToggleTerm");
end

vim.keymap.set('n', "<leader>t", "<cmd>ToggleTerm direction=vertical size=100<CR>")
vim.keymap.set('t', '<leader>t', exitTerm)
