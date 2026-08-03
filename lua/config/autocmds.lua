local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- 是否正在退出：退出流程中要跳过 startinsert，否则关窗时焦点扫过 terminal
-- 会触发 startinsert 去等子进程输入，与退出销毁互等，导致 :qa 假死。
local quitting = false

-- 退出前的收尾：标记退出中，并主动结束所有 terminal job，
-- 避免 nvim 卡在 TUI 拆卸阶段等待子进程。
augroup("QuitCleanup", { clear = true })
autocmd("ExitPre", {
  group = "QuitCleanup",
  callback = function()
    quitting = true
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local ok, chan = pcall(function()
        return vim.api.nvim_buf_get_var(buf, "terminal_job_id")
      end)
      if ok and chan then
        pcall(vim.fn.jobstop, chan)
      end
    end
  end,
})

-- 自动保存 session（terminal 窗口在场时 mksession 可能抛错，用 pcall 兜底；
-- 并排除 terminal，避免恢复时残留死窗口）
augroup("SaveSession", { clear = true })
autocmd("VimLeave", {
  group = "SaveSession",
  callback = function()
    local saved = vim.o.sessionoptions
    vim.o.sessionoptions = saved:gsub(",?terminal", "")
    pcall(function()
      vim.cmd("mksession! " .. vim.fn.fnameescape(vim.fn.getcwd() .. "/.session.vim"))
    end)
    vim.o.sessionoptions = saved
  end,
})

-- Terminal 自动 insert 模式
augroup("TermInsert", { clear = true })
autocmd("BufEnter", {
  group = "TermInsert",
  callback = function()
    if quitting then
      return
    end
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

-- .iss 文件编码：仓库统一 UTF-8 带 BOM（Inno Setup 靠 BOM 识别 Unicode，无 BOM 会按 ANSI 读中文注释导致乱码），LF 行尾
augroup("InnoSetup", { clear = true })
-- 读入后 / 新建时：确保写回时保持 UTF-8 + BOM + LF（即使文件原本无 BOM，保存时也会补上）
autocmd({ "BufReadPost", "BufNewFile" }, {
  group = "InnoSetup",
  pattern = "*.iss",
  callback = function()
    vim.bo.fileencoding = "utf-8"
    vim.bo.fileformat = "unix"
    vim.bo.bomb = true
  end,
})
