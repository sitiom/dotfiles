local M = {}

M.g = {
  catppuccin_flavour = "mocha",
}

M.opt = {
  relativenumber = true,
  guifont = "Delugia:h10",
  clipboard = "",
  list = true,
  listchars = {
    tab = "→ ",
    extends = "⟩",
    precedes = "⟨",
    trail = "·",
    nbsp = "␣",
    eol = "↲",
  },
}

M.o = {}

-- Use PowerShell in Windows
if vim.fn.has "win32" == 1 then
  M.o.shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
  M.o.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  M.o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
  M.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  M.opt.shellquote = ""
  M.opt.shellxquote = ""
end

return M
