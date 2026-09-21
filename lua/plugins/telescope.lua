return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope", "Ag", "Rag" },
    keys = {
      { "<C-p>", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = {
            "node_modules",
            ".git/",
            "dist/",
            "out/",
            "build/",
            "target/",
            ".cache/",
            ".next/",
            ".nuxt/",
            ".output/",
            "vendor/",
          },
          mappings = {
            -- <C-v> 在 Windows 终端会被当成粘贴，改用 <C-s> 左右分割打开
            i = {
              ["<C-s>"] = actions.select_vertical,
              ["<C-v>"] = false,
            },
            n = {
              ["<C-s>"] = actions.select_vertical,
              ["<C-v>"] = false,
            },
          },
        },
        pickers = {
          find_files = { hidden = true },
        },
      })
      vim.api.nvim_create_user_command("Ag", function(opts)
        require("telescope.builtin").live_grep({
          default_text = opts.args,
          additional_args = function()
            return { "--hidden" }
          end,
        })
      end, { nargs = "?" })
      vim.api.nvim_create_user_command("Rag", function(opts)
        require("telescope.builtin").live_grep({
          default_text = opts.args,
          additional_args = function()
            return { "--hidden" }
          end,
        })
      end, { nargs = "?" })
    end,
  },
}
