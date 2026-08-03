return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local function on_attach(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- 先加载默认映射
        api.config.mappings.default_on_attach(bufnr)

        -- <C-v> 在 Windows 终端会被当成粘贴，改用单键：s 左右分割 / i 上下分割
        pcall(vim.keymap.del, "n", "<C-v>", { buffer = bufnr })
        vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "i", api.node.open.horizontal, opts("Open: Horizontal Split"))
      end

      require("nvim-tree").setup({
        on_attach = on_attach,
        view = { width = 30 },
        git = { enable = false },
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        filters = {
          dotfiles = false,
          custom = { "node_modules", ".vscode" },
        },
        filesystem_watchers = {
          ignore_dirs = { ".husky", "node_modules", ".git" },
        },
        renderer = { icons = { show = { git = false, folder = true, file = true } } },
      })
      vim.keymap.set("n", "<leader>b", "<cmd>NvimTreeToggle<CR>", { silent = true, noremap = true })
    end,
  },
}
