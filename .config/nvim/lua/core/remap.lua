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

vim.keymap.set("n", "<C-j>", "<C-w>j");
vim.keymap.set("n", "<C-k>", "<C-w>k");
vim.keymap.set("n", "<C-l>", "<C-w>l");
vim.keymap.set("n", "<C-h>", "<C-w>h");
vim.keymap.set("n", "0", "^");
vim.keymap.set("n", ")", "<Home>"); -- I dont use sentences or paragraph based motions so idc about losing )

vim.keymap.set("n", "<leader>gb", ":ls<CR>:b");
