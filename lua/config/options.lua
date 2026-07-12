vim.g.loaded_perl_provider = 0
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.mouse = "r"
vim.opt.clipboard = "unnamedplus"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 300
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess:append("c")
-- 按终端能力决定是否开启真彩色,避免在不支持的终端(如 macOS Terminal.app)下出现色块。
-- Windows 现代终端(Windows Terminal 等)默认支持,但不一定设置 COLORTERM,故单独放行。
-- 存成全局函数,供 autocmds 在主题加载后再次强制应用(主题会硬编码开启真彩色)。
function _G.apply_termguicolors()
  local colorterm = vim.env.COLORTERM or ""
  vim.opt.termguicolors = colorterm == "truecolor"
    or colorterm == "24bit"
    or vim.fn.has("win32") == 1
end
_G.apply_termguicolors()
