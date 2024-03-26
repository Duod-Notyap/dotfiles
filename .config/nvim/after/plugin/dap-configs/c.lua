local dapui = require("dapui")
local dap = require("dap")
local C_BUILDDIR = ".build"

function file_exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end

--- Check if a directory exists in this path
function dir_exists(path)
   -- "/" works on both Unix and Windows
   return file_exists(path.."/")
end

function buildConfig(opts)
    local ret = {
        name = "Launch C (gdb)",
        type = "cppgdb",
        request = "launch",
        cwd = "${workspaceFolder}"
    }

    if opts == nil then
        opts = {
            args = false
        }
    end

    if opts.args then
        ret.args = function()
            local args = vim.fn.input("Arguments: ")
            return vim.split(args, " +")
        end
    end

    if not opts.program then
        ret.program = function()
            return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/', 'file')
        end
    else
        ret.program = opts.program
    end

    return ret
end

function prep_opts(opts)
    if type(opts.program) == "function" then
        opts.program = opts.program()
    end

    return opts;
end

LAST_RAN_CONFIG = nil
function run(opts)
    opts = prep_opts(opts)

    LAST_RAN_CONFIG = opts
    dap.run(opts)
end

function rerun()
    if LAST_RAN_CONFIG == nil then
        vim.fn.printf('No Previously ran config')
    else
        run(LAST_RAN_CONFIG)
    end
end

function runBuilt(opts)
    run(buildConfig(opts))
end


-- C BUILD LOGIC
function runCmake(printFn, opts)
    local done = false
    local jobId 
    jobId = vim.fn.jobstart("cd " .. C_BUILDDIR .. " && cmake .. -DCMAKE_BUILD_TYPE=Debug", {
        on_stdout = function(_, text)
            printFn(jobId, text)
        end,
        on_stderr = function(_, text)
            printFn(jobId, text)
        end,
        on_exit = function()
            runMake(printFn, opts)
        end
    });
end

function runMake(printFn, opts)
    local done = false
    local jobId 
    jobId = vim.fn.jobstart("cd " .. C_BUILDDIR .. " && make", {
        on_stdout = function(_, text)
            printFn(jobId, text)
        end,
        on_stderr = function(_, text)
            printFn(jobId, text)
        end,
        on_exit = function(_, code)
            printFn(jobId, { "Build finished with code " .. code })
            if code == 0 then
                runBuilt(opts)
            end
        end
    });
end

function initCBuilddir(printFn)
    local done = false
    if not dir_exists("${workspaceFolder}"..C_BUILDDIR) then
        local jobId
        jobId = vim.fn.jobstart("mkdir " .. C_BUILDDIR, {
            on_stdout = function(_, text)
                printFn(jobId, text)
            end,
            on_stderr = function(_, text)
                printFn(jobId, text)
            end
        })
        vim.fn.jobwait({ jobId })
    end
end

function compileCmake(printFn, opts)
    initCBuilddir(printFn)
    if not file_exists("${workspaceFolder}" .. "/" .. C_BUILDDIR .. "/" .. "Makefile") then
        runCmake(printFn, opts)
    else
        runMake(printFn, opts)
    end
end

function tryCompileC(opts)
    opts.program = function()
        return "${workspaceFolder}" .. "/" .. C_BUILDDIR .. "/" .. vim.fn.input('Executable: ')
    end

    return function()
        local consoleBuffer = dapui.elements.console.buffer()
        local globJobId
        local channel = vim.api.nvim_open_term(consoleBuffer, {
            on_input = function(_, _, _, data)
                pcall(vim.api.nvim_chan_send, globJobId, data)
            end
        })

        local function print(jobId, data)
            globJobId = jobId
            local count = #data;
            for idx, line in pairs(data) do
                if idx == count then
                    local ok = pcall(vim.api.nvim_chan_send, channel, line)
                    if not ok then return end
                else
                    local ok = pcall(vim.api.nvim_chan_send, channel, line .. '\n')
                    if not ok then return end
                end
            end
        end

        if file_exists("CMakeLists.txt") then
            compileCmake(print, opts)
        else
            print("No CMakeLists.txt")
        end

        return nil;
    end
end

function runBasic(opts)
    return function()
        run(buildConfig(opts))
    end
end

return {
    tryCompileC = tryCompileC,
    configs = {
        {
            name = "Re Run Last",
            type = "cppgdb",
            request = "launch",
            program = rerun,
            cwd = "${workspaceFolder}"
        },{
            name = "Launch C (gdb)",
            type = "cppgdb",
            request = "launch",
            program = runBasic(),
            cwd = "${workspaceFolder}"
        }, {
            name = "Launch C (gdb) [args]",
            type = "cppgdb",
            request = "launch",
            program = runBasic({ args = true }),
            cwd = "${workspaceFolder}",
            args = function()
                local args = vim.fn.input("Arguments: ")
                return vim.split(args, " +")
            end
        }, {
            name = "Compile/Launch C (gdb)",
            type = "cppgdb",
            request = "launch",
            program = tryCompileC({ args = false }),
            cwd = "${workspaceFolder}"
        }, {
            name = "Compile/Launch C (gdb) [args]",
            type = "cppgdb",
            request = "launch",
            program = tryCompileC({ args = true }),
            cwd = "${workspaceFolder}"
        }, {
            name = "Attach to server :1234",
            type = "cppgdb",
            request = "launch",
            MIMode = "gdb",
            miDebuggerServerAddress = "localhost:1234",
            miDebuggerPath = "/usr/local/bin/gdb",
            cwd = "${workspaceFolder}",
            program = function()
                return vim.fn.input('Executable: ', vim.fn.getcwd() .. '/', 'file')
            end
        }
    }
}
