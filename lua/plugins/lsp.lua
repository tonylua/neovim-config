return {
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.lsp.config("ts_ls", {
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
      })

      vim.lsp.config("vue_ls", {
        filetypes = { "vue" },
      })

      vim.lsp.config("tailwindcss", {
        filetypes = { "html", "css", "vue", "typescript", "typescriptreact", "javascriptreact" },
      })

      vim.lsp.config("eslint", {
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
      })

      vim.lsp.enable({ "ts_ls", "vue_ls", "tailwindcss", "eslint" })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
          end
          map("n", "gd", vim.lsp.buf.definition)
          map("n", "gr", vim.lsp.buf.rename)
          map("n", "gy", vim.lsp.buf.type_definition)
          map("n", "K", vim.lsp.buf.hover)
          map("n", "[a", vim.diagnostic.goto_prev)
          map("n", "]a", vim.diagnostic.goto_next)
          map("n", "ga", vim.lsp.buf.code_action)
          map("n", "<Leader>a", vim.diagnostic.open_float)
          map("i", "<C-x><C-x>", vim.lsp.buf.signature_help)
        end,
      })

      vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        update_in_insert = true,
        underline = true,
        severity_sort = false,
        float = { border = "rounded", source = "always", header = "", prefix = "" },
      })

      local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, { focusable = false })
        end,
      })
    end,
  },
}
