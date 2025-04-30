--- @class AutoBraceArgs
--- @field open string The opening brace
--- @field close string The closing brace
--- @field enable_formatting? boolean Whether or not to allow "open<CR>" 
---         pretty formatting. default = true
--- @field enable_skip_closed? boolean Whether or not to skip adding 
---         closing brace when close is hit if one already exists.
---         default = true


--- Sets up auto brace closing
---@param args AutoBraceArgs
local function setupAutoBrace(args)
    setmetatable(args, {__index={enable_formatting = true, enable_skip_closed = true}})
    if args.enable_formatting then
        vim.keymap.set("i", args.open.. "<CR>", args.open .. "<CR>" .. args.close .. "<Up><End><CR>")
    end

    if args.open == args.close then
        if args.enable_skip_closed then
            vim.keymap.set("i", args.open, function()
                local row,col = unpack(vim.api.nvim_win_get_cursor(0))
                local at = vim.api.nvim_get_current_line():sub(col+1,col+1)
                if at ~= args.close then
                    vim.api.nvim_buf_set_text(0, row-1, col, row-1, col, { args.open..args.close })
                end
                vim.api.nvim_win_set_cursor(0, {row, col+1})
            end)
        else
            vim.keymap.set("i", args.open, args.open .. args.close .. "<Left>")
        end
    else
        vim.keymap.set("i", args.open, args.open .. args.close .. "<Left>")
        if args.enable_skip_closed then
            vim.keymap.set("i", args.close, function()
                local row,col = unpack(vim.api.nvim_win_get_cursor(0))
                local at = vim.api.nvim_get_current_line():sub(col+1,col+1)
                if at ~= args.close then
                    vim.api.nvim_buf_set_text(0, row-1, col, row-1, col, { args.close })
                end
                vim.api.nvim_win_set_cursor(0, {row, col+1})
            end)
        end
    end
end

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

-- Bracket completion
setupAutoBrace{open='{', close='}'}
setupAutoBrace{open='(', close=')'}
setupAutoBrace{open='[', close=']'}
setupAutoBrace{open='<', close='>', enable_formatting = false}
setupAutoBrace{open='"', close='"', enable_formatting = false}
setupAutoBrace{open="'", close="'", enable_formatting = false}

vim.keymap.set("n", "<leader>br", "i<CR><Esc>k$")
vim.keymap.set({'n', 'i', 'v'}, '<F1>', '') -- I dont want it

vim.keymap.set("n", "G", "Gzz"); -- Personal preference...
vim.keymap.set("n", "<leader>qr", ":mks! .sess.vim<CR>:wqa<CR>")
vim.keymap.set("n", "<leader>sl", ":so .sess.vim<CR>")

