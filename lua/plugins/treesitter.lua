return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.treesitter.language.register("typescript", "typescriptreact")
      vim.treesitter.language.register("typescript", "javascript")
      vim.treesitter.language.register("html", "vue")

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "lua", "typescript", "tsx", "vue", "html", "css", "json", "javascript" },
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },
}
