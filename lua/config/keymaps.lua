local map = vim.keymap.set

-- 窗口切换
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("t", "<C-h>", "<C-\\><C-n><C-w>h")
map("t", "<C-j>", "<C-\\><C-n><C-w>j")
map("t", "<C-k>", "<C-\\><C-n><C-w>k")
map("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Terminal 退出
map("t", "<Esc>", "<C-\\><C-n>")

-- 集成终端
local function open_terminal()
  if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    vim.cmd("split term://powershell.exe")
  else
    vim.cmd("split term://bash")
  end
  vim.cmd("resize 10")
end
map("n", "<C-n>", open_terminal)

-- Git blame
map("n", "<Leader>g", ":<C-u>call gitblame#echo()<CR>", { silent = true })

-- 翻译
vim.g.translator_default_engines = { "youdao", "bing", "haici" }
