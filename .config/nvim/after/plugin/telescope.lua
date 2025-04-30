local harpoon = require("harpoon");

harpoon = harpoon:setup({
    ["buffers"] = {
        create_list_item = function(val)
            error("Buffers list must pass value")
        end,
        select = function(item)
            vim.cmd("b " .. item.context)
        end
    }
})

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-S-H>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-L>", function() harpoon:list():next() end)

function string.tohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end

vim.keymap.set("n", "<leader>gb", function()
    local out = vim.api.nvim_exec2('ls', { output = true })
    if out.output == nil then
        return
    end

    harpoon:list("buffers"):clear()

    for line in out.output:gmatch("([^\n]*)\n?") do
        if line == nil or line:len() <= 0 then goto continue end

        local match = line:match("^%s*([0-9]+)");
        local data = tonumber(match);
        if data == nil or data == 0 then goto continue end

        harpoon:list("buffers"):add({
            value = line,
            context = data
        })
        ::continue::
    end

    harpoon.ui:toggle_quick_menu(harpoon:list("buffers"));
end)

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
