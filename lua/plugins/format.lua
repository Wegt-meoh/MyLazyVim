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
}
