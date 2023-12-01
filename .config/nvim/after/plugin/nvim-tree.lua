local api = require("nvim-tree.api")
require("nvim-tree").setup({})

vim.keymap.set('n', '<leader>pt', function() 
    api.tree.toggle();
    api.tree.focus();
end)
