local harpoon = require("harpoon"):setup()
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-S-H>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-L>", function() harpoon:list():next() end)

local builtin = require('telescope.builtin')
local tutils = require("telescope.utils")
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pw', function()
    builtin.find_files({ cwd = tutils.buffer_dir() })
end)
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
