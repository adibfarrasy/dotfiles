require("nvim-tree").setup(
    {
        modified = {
            enable = true,
            show_on_dirs = true,
            show_on_open_dirs = true,
        },
        view = {
            width = 45,
        },
    }
)

vim.keymap.set('n', '<leader>t', "<cmd>NvimTreeToggle<cr>", {})
