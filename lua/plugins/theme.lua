-- Define your default at the top
local default_theme = "monokai-pro" -- Change this to switch defaults

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    config = function()
      require("tokyonight").setup()
      if default_theme == "tokyonight" then
        vim.cmd.colorscheme("tokyonight")
      end
    end,
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    config = function()
      require("monokai-pro").setup()
      if default_theme == "monokai-pro" then
        vim.cmd.colorscheme("monokai-pro")
        -- if you want to set custome cursorline color you should disable cursorline guide in iterm.app
        vim.api.nvim_set_hl(0, "CursorLine", { bg = "#3d3d33" })
        vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#f6ae05", bold = true })
        vim.api.nvim_set_hl(0, "NonText", { fg = "#006400" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "Visual", { bg = "#3d3d33" })
      end
    end,
  },
}
