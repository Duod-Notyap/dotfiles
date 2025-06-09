vim.cmd.nmap('s', '<plug>(SubversiveSubstitute)');
vim.cmd.nmap('ss', '<plug>(SubversiveSubstituteLine)');
vim.cmd.nmap('S', '<plug>(SubversiveSubstituteToEndOfLine)');

vim.cmd.nmap('<leader>s', '<plug>(SubversiveSubstituteRange)');
vim.cmd.xmap('<leader>s', '<plug>(SubversiveSubstituteRange)');
vim.cmd.nmap('<leader>ss', '<plug>(SubversiveSubstituteWordRange)');

vim.cmd.nmap('<c-p>', '<plug>(YoinkPostPasteSwapBack)');
vim.cmd.nmap('<c-n>', '<plug>(YoinkPostPasteSwapForward)');

vim.cmd.nmap('p', '<plug>(YoinkPaste_p)');
vim.cmd.nmap('P', '<plug>(YoinkPaste_P)');

vim.cmd.nmap('gp', '<plug>(YoinkPaste_gp)');
vim.cmd.nmap('gP', '<plug>(YoinkPaste_gP)');
