require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "css",
        "dockerfile",
        "dot",
        "go",
        "gomod",
        "html",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "python",
        "rust",
        "sql",
        "todotxt",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "proto",
    },
    highlight = {
        enable = true
    },
}
