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
    "zivyangll/git-blame.vim",
    cmd = "GitBlame",
    keys = {
      { "<Leader>g", ":<C-u>call gitblame#echo()<CR>", silent = true },
    },
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
}
