return {
  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gcc", { "gc", mode = "v" } },
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },
  {
    "rmagatti/goto-preview",
    keys = {
      { "gpd", function() require("goto-preview").goto_preview_definition() end },
      { "gpt", function() require("goto-preview").goto_preview_type_definition() end },
      { "gpi", function() require("goto-preview").goto_preview_implementation() end },
      { "gpr", function() require("goto-preview").goto_preview_references() end },
      { "gP", function() require("goto-preview").close_all_win() end },
    },
    config = function()
      require("goto-preview").setup({})
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        current_line_blame = false,
      })
      vim.api.nvim_create_user_command("GitBlame", function()
        require("gitsigns").blame_line({ full = true })
      end, {})
      vim.keymap.set("n", "<Leader>g", function()
        require("gitsigns").blame_line({ full = true })
      end, { silent = true, desc = "Git blame line" })
    end,
  },
  {
    "voldikss/vim-translator",
    cmd = { "Translate", "TranslateW", "TranslateR" },
    keys = { "<Leader>t" },
    init = function()
      vim.g.translator_default_engines = { "youdao", "bing", "haici" }
    end,
  },
  {
    "editorconfig/editorconfig-vim",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-highlight-colors").setup({})
    end,
  },
}
