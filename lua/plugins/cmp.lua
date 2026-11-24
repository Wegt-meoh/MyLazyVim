return {
  { "L3MON4D3/LuaSnip" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<C-i>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        },
        sources = {
          { name = "minuet", priority = 100 },
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
        performance = {
          -- It is recommended to increase the timeout duration due to
          -- the typically slower response speed of LLMs compared to
          -- other completion sources. This is not needed when you only
          -- need manual completion.
          fetching_timeout = 2000,
        },
      })
    end,
  }, -- Autocompletion

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },
}
