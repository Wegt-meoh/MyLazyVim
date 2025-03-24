local map = vim.keymap.set
local on_attach = function(_, buffer)
  local opts = { noremap = true, silent = true, buffer = buffer }
  map("n", "gk", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
end

return {
  -- LSP (Language Server Protocol)
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      lspconfig.rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy", -- Use `clippy` for advanced linting on save
            },
            cargo = {
              allFeatures = true, -- Enable all Cargo features
            },
            diagnostics = {
              enable = true, -- Enable diagnostics (lint-like messages)
            },
          },
        },
      })

      lspconfig.yamlls.setup({
        cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml", "yml" },
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          yaml = {
            schemas = {
              ["http://json.schemastore.org/github-workflow"] = "/.github/workflows/*",
              ["http://json.schemastore.org/ansible-playbook-2.0"] = "/ansible/**/*.yml",
            },
          },
        },
      })

      lspconfig.ts_ls.setup({ on_attach = on_attach, capabilities = capabilities })
      lspconfig.cssls.setup({ on_attach = on_attach, capabilities = capabilities })
      lspconfig.html.setup({ on_attach = on_attach, capabilities = capabilities })
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- 🖊️ Formatters
          null_ls.builtins.formatting.stylua, -- Lua
          null_ls.builtins.formatting.black, -- Python
          null_ls.builtins.formatting.shfmt, -- Shell

          -- 🔍 Linters
          require("none-ls.diagnostics.eslint_d"), -- JavaScript/TypeScript
          null_ls.builtins.diagnostics.selene, -- Lua

          -- 🔧 Code Actions
          null_ls.builtins.code_actions.gitsigns, -- Git staging actions
          require("none-ls.code_actions.eslint_d"), -- JavaScript/TypeScript
        },
        on_attach = on_attach,
      })
    end,
  },

  {
    "kampfkarren/selene",
    dependencies = { "neovim/nvim-lspconfig" },
  },
}
