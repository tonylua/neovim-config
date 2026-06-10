return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = { width = 30 },
        git = { enable = false },
        filters = {
          dotfiles = false,
          custom = { "node_modules", ".vscode" },
        },
        renderer = { icons = { show = { git = false, folder = true, file = true } } },
      })
      vim.keymap.set("n", "<leader>b", "<cmd>NvimTreeToggle<CR>", { silent = true, noremap = true })
    end,
  },
}
