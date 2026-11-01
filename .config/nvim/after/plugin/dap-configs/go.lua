local dap = require("dap")
local dapGo = require("dap-go")

local harpoon = require("harpoon")
HListGoPackagesMain = "go.packages.main"

--- @type function|nil
local goPackagesMainCallback = nil

harpoon = harpoon:setup({
    [HListGoPackagesMain] = {
        select = function(item)
            if goPackagesMainCallback ~= nil then
                goPackagesMainCallback(item.context)
            end
        end,
    }
})

local function execShell(command)
    local f = assert(io.popen(command, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    return s
end

--- Gets the file path to the package, by it's import path
--- @param package any
local function getPackageDir(package)
    return execShell("go list -f '{{.Dir}}' " .. package .. " | tr -d ' \\t\\n'")
end

local function getMainPackages()
    local s = execShell("go list -f '{{.ImportPath}} {{.Name}}' ./... | awk '/ main$/ {print $1}'")
    if s == "" then return {} end

    local list = {}
    for package in string.gmatch(s, "[^%s]+") do
        table.insert(list, package)
    end
    return list
end

local function selectMainPackage()
    local list = harpoon:list(HListGoPackagesMain)
    list:clear()

    local count = 0;
    for _, line in ipairs(getMainPackages()) do
        count = count + 1
        list:add({ value = line, context = line })
    end

    harpoon.ui:toggle_quick_menu(list, {
        height_in_lines = math.min(count, 16),
    });
end

return {
    {
        type = "go",
        name = "Execute Precompiled",
        request = "launch",
        mode = "exec",
        program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. '/', 'file')
        end,
    },
    {
        type = "go",
        name = "Debug Other Package",
        request = "launch",
        mode = "exec",
        program = function()
            goPackagesMainCallback = function(value)
                dap.run({
                    name = value,
                    type = "go",
                    request = "launch",
                    cwd = "${workspaceFolder}",
                    program = getPackageDir(value),
                    buildFlags = {},
                    outputMode = 'remote'
                })
            end

            selectMainPackage()
            return dap.ABORT
        end,
    }
}
