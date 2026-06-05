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

function continue()
    if not is_open then
        toggle_panes()
    end
    local coro = coroutine.create(function()
        dap.continue()
    end)
    coroutine.resume(coro)
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
vim.keymap.set("n", "<leader>de", dapui.eval)
vim.keymap.set("n", "<F5>", function (fallback)
    if not is_open then
        toggle_panes()
    end
    continue();
end)
vim.keymap.set("n", "<F6>", function (fallback)
    dap.terminate()
    dap.close()
    if not is_open then
        toggle_panes()
    end
    continue();
end)
vim.keymap.set("n", "<F10>", dap.step_over)
vim.keymap.set("n", "<F11>", dap.step_into)
vim.keymap.set("n", "<F17>", function (fallback)
    close_panes()
    dap.terminate()
    dap.close()
end)

local adapterFiles = { "c", "node" }

for i,file in ipairs(adapterFiles) do
    local adapters = require("after.plugin.dap-adapters." .. file)
    for k,v in pairs(adapters) do
        dap.adapters[k] = v
    end
end
--- Check if a file or directory exists in this path

dap.configurations.c = require("after.plugin.dap-configs.c").configs
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

dap.configurations.javascript = require("after.plugin.dap-configs.node").configs

require('dap-go').setup({
  dap_configurations = {
      {
          type = "go",
          name = "Execute Precompiled",
          request = "launch",
          mode = "exec",
          program = function()
              return vim.fn.input("Executable: ", vim.fn.getcwd() .. '/', 'file')
          end,
      },
  },
  delve = {
      path = "dlv",
      initialize_timeout_sec = 20,
      port = "${port}",
      args = {},
      -- the build flags that are passed to delve.
      -- defaults to empty string, but can be used to provide flags
      -- such as "-tags=unit" to make sure the test suite is
      -- compiled during debugging, for example.
      -- passing build flags using args is ineffective, as those are
      -- ignored by delve in dap mode.
      -- avaliable ui interactive function to prompt for arguments get_arguments
      build_flags = {},
      -- whether the dlv process to be created detached or not. there is
      -- an issue on delve versions < 1.24.0 for Windows where this needs to be
      -- set to false, otherwise the dlv server creation will fail.
      -- avaliable ui interactive function to prompt for build flags: get_build_flags
      detached = vim.fn.has("win32") == 0,
      cwd = nil,
  },
  tests = {
      verbose = false,
  },
})
