return {
  {
    "folke/tokyonight.nvim",
    config = function()
      -- Setup must be called before colorscheme
      require("tokyonight").setup({
        style = "night", -- "storm", "night", "day", "moon"
        transparent = false, -- Enable transparent background
        terminal_colors = true, -- Configure terminal colors
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
        },
        on_colors = function(colors)
          -- Customize specific colors
          -- colors.bg = "#000000" -- Change background to pure black
          -- colors.bg_dark = "#000000"
          -- colors.bg_float = "#1a1b26"
          -- colors.bg_highlight = "#2c2d3a"
          -- colors.bg_popup = "#1a1b26"
          -- colors.bg_sidebar = "#1a1b26"
          -- colors.bg_statusline = "#1a1b26"
        end,
        on_highlights = function(highlights, colors)
          -- Override specific highlight groups
          highlights.Visual = { bg = "#6a8bc0", fg = "#ffffff" }
        end,
      })

      -- Apply the colorscheme after setup
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
