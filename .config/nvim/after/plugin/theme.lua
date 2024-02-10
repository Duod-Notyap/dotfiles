local startup = require("startup")
startup.setup({ theme = "evil" })

require("monokai-pro").setup {

  devicons = true,
  styles = {
    comment = { italic = false },
    keyword = { italic = false }, -- any other keyword
    type = { italic = false }, -- (preferred) int, long, char, etc
    storageclass = { italic = false }, -- static, register, volatile, etc
    structure = { italic = false }, -- struct, union, enum, etc
    parameter = { italic = false }, -- parameter pass in function
    annotation = { italic = false },
    tag_attribute = { italic = false }, -- attribute of tag in reactjs
  }
}

-- vim.cmd("colorscheme no-clown-fiesta")
vim.cmd("set termguicolors")
vim.cmd("colorscheme deep-space")
