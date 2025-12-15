local home_dir = os.getenv("HOME")
package.path = home_dir .. "/.config/nvim/?.lua;" .. package.path
require("core")
require("core.remap")
require("config.lazy")

vim.cmd("source " .. home_dir .. "/.config/nvim/include.vim")
