return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/" },
        },
        pickers = {
          find_files = { hidden = true },
        },
      })
    end,
  },
}
