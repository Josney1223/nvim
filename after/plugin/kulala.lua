vim.keymap.set("n", "<leader>Rs", function() require("kulala").run() end, { desc = "Send request" })
vim.keymap.set("n", "<leader>Ra", function() require("kulala").run_all() end, { desc = "Send all requests" })
vim.keymap.set("n", "<leader>Rb", function() require("kulala").scratchpad() end, { desc = "Open scratchpad" })
