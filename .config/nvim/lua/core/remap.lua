vim.g.mapleader = " "

--I dislike hitting ":" a lot
vim.keymap.set("n", "<leader>qq", ":qa<CR>")
vim.keymap.set("n", "<leader>qw", ":wqa<CR>")

--tabs
vim.keymap.set("n", "<leader>ty", ":tabnext<CR>")
vim.keymap.set("n", "<leader>tr", ":tabprevious<CR>")
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>")
vim.keymap.set("n", "<leader>tq", ":tabclose<CR>")
vim.keymap.set("n", "<leader>to", ":tabonly<CR>")
vim.keymap.set("n", "<leader>te", "<C-W>T") --Extrapolate

