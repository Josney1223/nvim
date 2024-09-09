require('todo-comments').setup()
vim.keymap.set("n", "]t", function()
    require("todo-comments").jump_next()
end, { desc = "Next todo comment" })

vim.keymap.set("n", "[t", function()
    require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })

-- TODO: What else?
-- FIX: This needs fixing
-- HACK: Something fishy here
-- PERF: Fully optimized
-- NOTE: Adding a note
-- WARNING: ????
