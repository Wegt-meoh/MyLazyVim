return {
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
          adaptive_size = true,
        },
        renderer = {
          icons = {
            show = {
              git = true,
              folder = true,
              file = true,
            },
          },
        },
        git = {
          enable = true,
        },
      })
    end,
  },
  { "nvim-tree/nvim-web-devicons" },
}
