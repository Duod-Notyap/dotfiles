vim.g.EasyMotion_smartcase = 1;

vim.keymap.set("n", "/", "<Plug>(easymotion-sn)");
vim.keymap.set("n", "n", "<Plug>(easymotion-next)");
vim.keymap.set("n", "N", "<Plug>(easymotion-prev)");
vim.keymap.set("n", "<Leader>l", "<Plug>(easymotion-lineforward)");
vim.keymap.set("n", "<Leader>j", "<Plug>(easymotion-j)");
vim.keymap.set("n", "<Leader>k", "<Plug>(easymotion-k)");
vim.keymap.set("n", "<Leader>h", "<Plug>(easymotion-linebackward)");
vim.keymap.set("n", "<Leader>f", "<Plug>(easymotion-s)");
vim.keymap.set("n", "<Leader>w", "<Plug>(easymotion-bd-w)");
vim.keymap.set("n", "<Leader>W", "<Plug>(easymotion-bd-W)");
vim.keymap.set("n", "<Leader>e", "<Plug>(easymotion-bd-e)");
vim.keymap.set("n", "<Leader>E", "<Plug>(easymotion-bd-E)");
