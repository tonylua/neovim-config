return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = { "ConformInfo", "Prettier" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          vue = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
        },
        format_on_save = function(bufnr)
          if vim.bo[bufnr].filetype == "iss" then
            return
          end
          return { timeout_ms = 2000, lsp_fallback = true }
        end,
      })
      vim.api.nvim_create_user_command("Prettier", function()
        require("conform").format({ async = true })
      end, {})
    end,
  },
}
