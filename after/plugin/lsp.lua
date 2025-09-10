---
-- LSP configuration
---

if _G['escolha'] ~= "2" then
    local lsp_zero = require('lsp-zero')
    local lsp_attach = function(client, bufnr)
        lsp_zero.buffer_autoformat()
        local opts = { buffer = bufnr }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end

    lsp_zero.extend_lspconfig({
        sign_text = true,
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
    })

    ---
    -- Autocompletion setup
    ---
    local cmp = require('cmp')

    cmp.setup({
        sources = {
            { name = 'nvim_lsp' },
        },
        snippet = {
            expand = function(args)
                -- You need Neovim v0.10 to use vim.snippet
                vim.snippet.expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({}),
    })

    require("mason").setup()
    require("mason-lspconfig").setup {
        ensure_installed = {
            "lua_ls",
            "gopls",
            "ts_ls",
            "eslint",
            "svelte",
            "tailwindcss",
        },
        handlers = {
            function(server_name)
                require('lspconfig')[server_name].setup({})
            end,
        }
    }

    require("lspconfig").lua_ls.setup {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {
                        'vim'
                    }
                }
            }
        }
    }

    require("lspconfig").pylsp.setup {
        plugins = {
            black = {
                enabled = true
            }
        }
    }
end
