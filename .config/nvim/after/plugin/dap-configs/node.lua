local dapui = require("dapui")
local dap = require("dap")

return {
    configs = {
        {
            name = "Launch File",
            type = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}"
        },
        {
            name = "Launch File (Specify)",
            type = "pwa-node",
            request = "launch",
            program = function()
                return vim.fn.input('Entrypoint: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = "${workspaceFolder}"
        }
    }
}
