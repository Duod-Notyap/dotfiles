vim.cmd.nmap('s', '<plug>(SubversiveSubstitute)');
vim.cmd.nmap('ss', '<plug>(SubversiveSubstituteLine)');
vim.cmd.nmap('S', '<plug>(SubversiveSubstituteToEndOfLine)');

vim.cmd.nmap('<leader>s', '<plug>(SubversiveSubstituteRange)');
vim.cmd.xmap('<leader>s', '<plug>(SubversiveSubstituteRange)');
vim.cmd.nmap('<leader>ss', '<plug>(SubversiveSubstituteWordRange)');

vim.cmd.nmap('<c-p>', '<plug>(YoinkPostPasteSwapBack)');
vim.keymap.set('n', '<c-n>', function()
    local can = vim.fn['yoink#canSwap']();
    if can == 1 then
        local keyPress = vim.api.nvim_replace_termcodes('<Plug>(YoinkPostPasteSwapForward)', true, false, true);
        vim.api.nvim_feedkeys(keyPress, 'n', false);
        print("can")
    else
        local keyPress = vim.api.nvim_replace_termcodes('<Plug>(VM-Find-Under)', true, false, true);
        vim.api.nvim_feedkeys(keyPress, 'n', false);
    end
end)

vim.cmd.nmap('p', '<plug>(YoinkPaste_p)');
vim.cmd.nmap('P', '<plug>(YoinkPaste_P)');

vim.cmd.nmap('gp', '<plug>(YoinkPaste_gp)');
vim.cmd.nmap('gP', '<plug>(YoinkPaste_gP)');
