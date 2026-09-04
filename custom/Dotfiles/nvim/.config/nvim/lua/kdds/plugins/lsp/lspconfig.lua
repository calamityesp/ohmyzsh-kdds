return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "Hoffs/omnisharp-extended-lsp.nvim",
        -- "Decodetalkers/csharpls-extended-lsp.nvim",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        keymap = vim.keymap
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- set keybinds
                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

                opts.desc = "Show LSP definitions"
                keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end,
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    -- make the language server recognize "vim" global
                    diagnostics = {
                        globals = { "vim" },
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                },
            },
        })
        -- used to enable autocompletion (assign to every lsp server config)
        -- local capabilities = cmp_nvim_lsp.default_capabilities()
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
        )
        -- local utils = require("lspconfig/util")

        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        -- local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        -- for type, icon in pairs(signs) do
        --     local hl = "DiagnosticSign" .. type
        --     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        -- end

        -- mason_lspconfig.setup_handlers({
        --     -- default handler for installed servers
        --     function(server_name)
        --         lspconfig[server_name].setup({
        --             capabilities = capabilities,
        --         })
        --     end,
        --     ["svelte"] = function()
        --         -- configure svelte server
        --         lspconfig["svelte"].setup({
        --             capabilities = capabilities,
        --             on_attach = function(client, bufnr)
        --                 vim.api.nvim_create_autocmd("BufWritePost", {
        --                     pattern = { "*.js", "*.ts" },
        --                     callback = function(ctx)
        --                         -- Here use ctx.match instead of ctx.file
        --                         client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
        --                     end,
        --                 })
        --             end,
        --         })
        --     end,
        --     ["graphql"] = function()
        --         -- configure graphql language server
        --         lspconfig["graphql"].setup({
        --             capabilities = capabilities,
        --             filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
        --         })
        --     end,
        --     ["emmet_ls"] = function()
        --         -- configure emmet language server
        --         lspconfig["emmet_ls"].setup({
        --             capabilities = capabilities,
        --             filetypes = {
        --                 "html",
        --                 "typescriptreact",
        --                 "javascriptreact",
        --                 "css",
        --                 "sass",
        --                 "scss",
        --                 "less",
        --                 "svelte",
        --             },
        --         })
        --     end,
        --     ["lua_ls"] = function()
        --         -- configure lua server (with special settings)
        --         lspconfig["lua_ls"].setup({
        --             capabilities = capabilities,
        --             settings = {
        --                 Lua = {
        --                     -- make the language server recognize "vim" global
        --                     diagnostics = {
        --                         globals = { "vim" },
        --                     },
        --                     completion = {
        --                         callSnippet = "Replace",
        --                     },
        --                 },
        --             },
        --         })
        --     end,
        --     ["ts_ls"] = function()
        --         lspconfig["ts_ls"].setup({
        --             capabilities = capabilities,
        --             init_options = {
        --                 preferences = {
        --                     disableSuggestions = true,
        --                 },
        --             },
        --             filetypes = {
        --                 "javascript",
        --                 "typescriptreact",
        --                 "javascriptreact",
        --                 "typescript",
        --                 "vue",
        --             },
        --         })
        --     end,
        --     ["gopls"] = function()
        --         lspconfig["gopls"].setup({
        --             capabilities = capabilities,
        --             cmd = { "gopls" },
        --             filetypes = { "go", "gomod", "gowork", "gotmpl" },
        --             root_dir = utils.root_pattern("go.work", "go.mod", ".git"),
        --             settings = {
        --                 gopls = {
        --                     completeUnimported = true,
        --                     usePlaceholders = true,
        --                     analyses = {
        --                         unusedparams = true,
        --                     },
        --                 },
        --             },
        --         })
        --     end,
        --     ["eslint"] = function()
        --         lspconfig["eslint"].setup({192.168.50.1
        --             cmd = { "node_modules/.bin/eslint", "--stdio" }, -- Ensure the path to local ESLint
        --             filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        --             settings = {
        --                 format = true,
        --             },
        --             -- codeAction = {
        --             --     disableRuleComment = {
        --             --         enable = true,
        --             --         location = "separateLine",
        --             --     },
        --             --     showDocumentation = {
        --             --         enable = true,
        --             --     },
        --             -- },
        --             -- codeActionOnSave = {
        --             --     enable = false,
        --             --     mode = "all",
        --             -- },
        --             -- experimental = {
        --             --     useFlatConfig = false,
        --             -- },
        --             -- format = true,
        --             -- nodePath = "",
        --             -- onIgnoredFiles = "off",
        --             -- problems = {
        --             --     shortenToSingleLine = false,
        --             -- },
        --             -- quiet = false,
        --             -- rulesCustomizations = {},
        --             -- run = "onType",
        --             -- useESLintClass = false,
        --             -- validate = "on",
        --             -- workingDirectory = {
        --             --     mode = "location",
        --             -- },
        --         })
        --     end,
        --     ["omnisharp"] = function()
        --         lspconfig["omnisharp"].setup({
        --
        --             cmd = {
        --                 "dotnet",
        --                 "/home/calamityesp/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll",
        --             },
        --
        --             on_attach = on_attach,
        --             capabilities = capabilities,
        --             settings = {
        --                 FormattingOptions = {
        --                     -- Enables support for reading code style, naming convention and analyzer
        --                     -- settings from .editorconfig.
        --                     EnableEditorConfigSupport = true,
        --                     -- Specifies whether 'using' directives should be grouped and sorted during
        --                     -- document formatting.
        --                     OrganizeImports = nil,
        --                 },
        --                 MsBuild = {
        --                     -- If true, MSBuild project system will only load projects for files that
        --                     -- were opened in the editor. This setting is useful for big C# codebases
        --                     -- and allows for faster initialization of code navigation features only
        --                     -- for projects that are relevant to code that is being edited. With this
        --                     -- setting enabled OmniSharp may load fewer projects and may thus display
        --                     -- incomplete reference lists for symbols.
        --                     LoadProjectsOnDemand = nil,
        --                 },
        --                 RoslynExtensionsOptions = {
        --                     -- Enables support for roslyn analyzers, code fixes and rulesets.
        --                     EnableAnalyzersSupport = true,
        --                     -- Enables support for showing unimported types and unimported extension
        --                     -- methods in completion lists. When committed, the appropriate using
        --                     -- directive will be added at the top of the current file. This option can
        --                     -- have a negative impact on initial completion responsiveness,
        --                     -- particularly for the first few completion sessions after opening a
        --                     -- solution.
        --                     EnableImportCompletion = true,
        --                     -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
        --                     -- true
        --                     AnalyzeOpenDocumentsOnly = nil,
        --                     EnableMetadataSupport = true,
        --                     EnableDecompilationSupport = true,
        --                 },
        --                 Sdk = {
        --                     -- Specifies whether to include preview versions of the .NET SDK when
        --                     -- determining which version to use for project loading.
        --                     IncludePrereleases = true,
        --                 },
        --             },
        --             handlers = {
        --                 ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
        --                 ["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
        --                 ["textDocument/references"] = require("omnisharp_extended").references_handler,
        --                 ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
        --             },
        --         })
        --     end,
        --     -- ["csharp_ls"] = function()
        --     --     lspconfig["csharp_ls"].setup({
        --     --
        --     --         handlers = {
        --     --             ["textDocument/definition"] = require("csharpls_extended").handler,
        --     --             ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
        --     --         },
        --     --         cmd = {
        --     --             "dotnet",
        --     --             "/home/calamityesp/.local/share/nvim/mason/packages/omnisharp/libexec/OmniSharp.dll",
        --     --         },
        --     --     })
        --     -- end,
        --     --
        --     ["cssls"] = function()
        --         lspconfig["cssls"].setup({
        --             settings = {
        --                 css = {
        --                     validate = true,
        --                     lint = {
        --                         unknownAtRules = "ignore",
        --                     },
        --                 },
        --                 scss = {
        --                     validate = true,
        --                     lint = {
        --                         unknownAtRules = "ignore",
        --                     },
        --                 },
        --                 less = {
        --                     validate = true,
        --                     lint = {
        --                         unknownAtRules = "ignore",
        --                     },
        --                 },
        --             },
        --         })
        --     end,
        --     ["tailwindcss"] = function()
        --         lspconfig["tailwindcss"].setup({})
        --     end,
        --     ["clangd"] = function()
        --         lspconfig["clangd"].setup({
        --             filetypes = { "c", "cpp", "obj", "objcpp", "proto", "hpp" },
        --         })
        --     end,
        -- })
    end,
}
