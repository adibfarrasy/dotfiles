require("adibf.remap")
require("adibf.packer")
require("adibf.globals")

require('colorizer').setup({})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.foldmethod = "indent"
vim.opt.foldenable = true
vim.opt.foldnestmax = 10
vim.opt.foldlevel = 3
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.hlsearch = false

vim.opt.colorcolumn = { '+1' }
vim.opt.textwidth = 80
vim.opt.wrap = false

vim.cmd("hi Normal guibg=none")
vim.cmd("hi NonText guifg=none guibg=none")
vim.cmd("hi LineNr guifg=#ebdbb2 guibg=#427b58")
vim.cmd("hi LineNrAbove guifg=#928374 guibg=none")
vim.cmd("hi LineNrBelow guifg=#928374 guibg=none")
vim.cmd("hi SignColumn guibg=none")
vim.cmd("hi EndOfBuffer guifg=#427b58 guibg=none")
vim.cmd("hi ColorColumn guibg=#9d0006")
vim.cmd("colorscheme gruvbox")
