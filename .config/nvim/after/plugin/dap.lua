local dap = require("dap")
local dapui = require("dapui")
dapui.setup()
local is_open = false;

function toggle_panes()
    is_open = not is_open
    dapui.toggle()
end

function close_panes()
    if is_open then
        toggle_panes()
    end
end

function open_panes()
    if not is_open then
        toggle_panes()
    end
end

function continue(opts)
    if not is_open then
        toggle_panes()
    end
    dap.continue()
end

function rust_initcommands()
      -- Find out where to look for the pretty printer Python module
      local rustc_sysroot = vim.fn.trim(vim.fn.system('rustc --print sysroot'))

      local script_import = 'command script import "' .. rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py"'
      local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'

      local commands = {}
      local file = io.open(commands_file, 'r')
      if file then
        for line in file:lines() do
          table.insert(commands, line)
        end
        file:close()
      end
      table.insert(commands, 1, script_import)

      return commands
end

vim.keymap.set("n", "<leader>dt", toggle_panes)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<F5>", function (fallback)
    if not is_open then
        toggle_panes()
    end
    continue();
end)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F17>", function (fallback)
    close_panes()
    dap.close()
end)

dap.adapters.cppgdb = {
    type = "executable",
    command = "/home/pdoud/cpptools-vscode/extension/debugAdapters/bin/OpenDebugAD7"
}

dap.configurations.c = {
    {
        name = "Launch C (gdb)",
        type = "cppgdb",
        request = "launch",
        program = function()
            return vim.fn.input('Executable', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true
    }, {
        name = "Attach to server :1234",
        type = "cppgdb",
        request = "launch",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:1234",
        miDebuggerPath = "/usr/local/bin/gdb",
        cwd = "${workspaceFolder}",
        program = function()
            return vim.fn.input('Executable', vim.fn.getcwd() .. '/', 'file')
        end
    }
}

dap.configurations.cpp = dap.configurations.c

dap.configurations.rust = {
    {
        name = "Launch Rust (gdb)",
        type = "cppgdb",
        request = "launch",
        program = function()
            return vim.fn.input('Executable', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = true,
        initCommands = rust_initcommands
    }, {
        name = "Attach to server :1234",
        type = "cppgdb",
        request = "launch",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:1234",
        miDebuggerPath = "/usr/local/bin/gdb",
        cwd = "${workspaceFolder}",
        program = function()
            return vim.fn.input('Executable', vim.fn.getcwd() .. '/', 'file')
        end,
        initCommands = rust_initcommands
    }
}
