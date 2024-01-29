require("mason").setup()
require("mason-lspconfig").setup()

local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
    -- autoformat on save
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Format", { clear = true }),
            buffer = bufnr,
            callback = function() vim.lsp.buf.format() end
        })
    end

    -- keybindings
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
    vim.keymap.set("n", "<leader>e", vim.diagnostic.goto_next, { buffer = 0 })
    vim.keymap.set("n", "<leader>E", vim.diagnostic.goto_prev, { buffer = 0 })
    vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", { buffer = 0 })
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = 0 })
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = 0 })
    vim.keymap.set('n', '<leader>s', function() vim.lsp.buf.format { async = true } end, { buffer = 0 })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Lua
nvim_lsp.lua_ls.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false
            },
        },
    },
}

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
    },
    highlight = {
        enable = true
    },
}

-- Go
nvim_lsp.gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

-- Typescript
nvim_lsp.tsserver.setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" }
}

-- Rust
nvim_lsp.rust_analyzer.setup {
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
}

-- Markdown
nvim_lsp.marksman.setup {}

-- Kotlin
nvim_lsp.kotlin_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Protocol Buffer
nvim_lsp.bufls.setup {}
