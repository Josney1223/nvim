local exitTerm = function ()
  vim.cmd(":ToggleTerm");
end

vim.keymap.set('n', "<C-t>", "<cmd>ToggleTerm direction=vertical size=100<CR>")
vim.keymap.set('t', '<esc><esc>', exitTerm)
