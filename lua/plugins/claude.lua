return {
  {
    "greggh/claude-code.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "ClaudeCode", "ClaudeCodeContinue" },
    keys = {
      { "<C-,>", "<cmd>ClaudeCode<cr>", mode = { "n", "t" }, desc = "Toggle Claude Code" },
      { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Claude Code continue" },
    },
    config = function()
      require("claude-code").setup({
        window = {
          split_ratio = 0.35,
          position = "botright",
          enter_insert = true,
          hide_numbers = true,
        },
        refresh = {
          enable = true,
          updatetime = 100,
          timer_interval = 1000,
        },
        keymaps = {
          toggle = {
            normal = "<C-,>",
            terminal = "<C-,>",
          },
          window_navigation = true,
          scrolling = true,
        },
      })
      vim.api.nvim_create_user_command("Claude", function(opts)
        vim.cmd("ClaudeCode " .. (opts.args or ""))
      end, { nargs = "?" })
      vim.cmd([[cabbrev claude Claude]])
    end,
  },
}
