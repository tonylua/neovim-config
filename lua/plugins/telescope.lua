return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope", "Ag", "Rag" },
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
      vim.api.nvim_create_user_command("Ag", function(opts)
        require("telescope.builtin").live_grep({ default_text = opts.args })
      end, { nargs = "?" })
      vim.api.nvim_create_user_command("Rag", function(opts)
        require("telescope.builtin").live_grep({ default_text = opts.args })
      end, { nargs = "?" })
    end,
  },
}
