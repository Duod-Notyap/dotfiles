local ng = require('neogen')

ng.setup({ snippet_engine = 'luasnip' })

vim.keymap.set('n', '<leader>dg', function()
    ng.generate({})
end)
