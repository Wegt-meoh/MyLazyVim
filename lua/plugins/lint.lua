return {
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
        yaml = { "yamllint" },
        lua = { "selene" },
        sh = { "shellcheck" }, -- Bash filetype is 'sh'
        json = { "jsonlint" },
      }

      vim.api.nvim_create_autocmd("DiagnosticChanged", {
        callback = function()
          vim.diagnostic.setqflist({ open = false })
        end,
      })

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint() -- LSP already gets didSave automatically
        end,
      })
    end,
  },
}
