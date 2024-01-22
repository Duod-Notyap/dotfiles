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

--Buffer resizing
vim.keymap.set("n", "<Esc><C-l>", "<C-W>>");
vim.keymap.set("n", "<Esc><C-h>", "<C-W><");
vim.keymap.set("n", "<Esc><C-j>", "<C-W>-");
vim.keymap.set("n", "<Esc><C-k>", "<C-W>+");

vim.keymap.set("n", "<Esc>j", "<C-w>j");
vim.keymap.set("n", "<Esc>k", "<C-w>k");
vim.keymap.set("n", "<Esc>l", "<C-w>l");
vim.keymap.set("n", "<Esc>h", "<C-w>h");
