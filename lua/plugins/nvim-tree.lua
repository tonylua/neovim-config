return {
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<C-b>", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        filters = {
          dotfiles = false,
          custom = { "node_modules", ".vscode" },
        },
        renderer = { icons = { show = { git = true, folder = true, file = true } } },
      })
    end,
  },
}
