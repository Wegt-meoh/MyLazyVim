return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- Lazy-load on save
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        rust = { "rustfmt" },
        lua = { "stylua" },
        sh = { "shfmt" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        vue = { "eslint_d" },
        css = { "eslint_d" }, -- if you have eslint-plugin-css
        json = { "eslint_d" },
        jsonc = { "eslint_d" },
        html = { "eslint_d" }, -- works if you have prettier-plugin-tailwind or eslint-plugin-html
        graphql = { "eslint_d" },
        markdown = { "eslint_d" },
        yaml = { "eslint_d" },
      },
      format_on_save = { timeout_ms = 500 },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      -- Linters by filetype (primaries; add more from supported list if needed)
      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        html = { "htmlhint" },
        css = { "stylelint" },
        c = { "clangtidy" },
        rust = { "clippy" },
        yaml = { "yamllint" },
        lua = { "selene" },
        sh = { "shellcheck" }, -- Bash filetype is 'sh'
        json = { "jsonlint" },
      }

      -- Auto-trigger linting
      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
          vim.defer_fn(function()
            vim.diagnostic.setqflist({ open = false }) -- Update Quickfix List
            -- Count only real errors/warnings (exclude INFO/HINT if you want)
            local diagnostics =
              vim.diagnostic.get(nil, { severity = { vim.diagnostic.severity.ERROR, vim.diagnostic.severity.WARN } })

            if #diagnostics > 0 then
              vim.cmd("copen")
              vim.cmd("wincmd p") -- return focus to code window
            else
              -- Only close if quickfix is open and we're in normal mode
              if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
                vim.cmd("cclose")
              end
            end
          end, 100)
        end,
      })
    end,
  },
}
