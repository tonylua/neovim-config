local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- 自动保存 session
augroup("SaveSession", { clear = true })
autocmd("VimLeave", {
  group = "SaveSession",
  callback = function()
    vim.cmd("mksession! " .. vim.fn.getcwd() .. "/.session.vim")
  end,
})

-- Terminal 自动 insert 模式
augroup("TermInsert", { clear = true })
autocmd("BufEnter", {
  group = "TermInsert",
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})

-- 主题会硬编码开启真彩色(如 dracula),这里在每次应用主题后按终端能力再纠正一次
augroup("TrueColorFix", { clear = true })
autocmd("ColorScheme", {
  group = "TrueColorFix",
  callback = function()
    if _G.apply_termguicolors then
      _G.apply_termguicolors()
    end
  end,
})

-- .iss 文件编码
augroup("InnoSetup", { clear = true })
autocmd({ "BufRead", "BufNewFile" }, {
  group = "InnoSetup",
  pattern = "*.iss",
  callback = function()
    vim.bo.fileencoding = "cp936"
    vim.bo.fileformat = "unix"
    vim.bo.bomb = false
  end,
})
