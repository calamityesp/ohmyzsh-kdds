-- ***********************************************************************************************
-- *** williamboman/mason.nvim  --lsp language server plugin manager (best there is)
-- ***********************************************************************************************

return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")
        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "ts_ls",
                "html",
                "cssls",
                "tailwindcss",
                "lua_ls",
                "graphql",
                "emmet_ls",
                "prismals",
                "pyright",
                "ruff",
                "clangd",
                "eslint",
                "omnisharp",
                -- "csharp_ls",
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "isort", -- python formatter
                "black", -- python formatter
                "pylint", -- python  linting
                "eslint_d", -- js linting
                "mypy",
                --            "clang-format", -- c  language formating
            },
        })
    end,
}
