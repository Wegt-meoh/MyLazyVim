return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup()
      require("nvim-treesitter").install({
        "rust",
        "javascript",
        "typescript",
        "jsdoc",
        "tsx",
        "html",
        "css",
        "json",
        "yaml",
        "scss",
        "lua",
        "bash",
        "make",
        "styled",
        "python",
      })
    end,
  },
}
