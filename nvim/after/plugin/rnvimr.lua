vim.g.rnvimr_enable_picker = 1
vim.g.rnvimr_edit_cmd = "drop"

vim.keymap.set("n", "<leader>rg", ":RnvimrToggle<cr>", { noremap = true, silent = true })
