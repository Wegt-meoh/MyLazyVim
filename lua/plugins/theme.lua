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
      end
    end,
  },
}
