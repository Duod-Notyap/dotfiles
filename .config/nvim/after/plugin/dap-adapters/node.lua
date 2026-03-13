local HOME = os.getenv("HOME")

return {
    ["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
            command = "node",
            args = { HOME .. "/.local/lib/js-debug/src/dapDebugServer.js", "${port}" }
        }
    }
}
