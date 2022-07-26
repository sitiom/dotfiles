if vim.fn.has "win32" == 1 then
   vim.o.shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
   vim.o.shellcmdflag =
      "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
   vim.o.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
   vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
   vim.opt.shellquote = ""
   vim.opt.shellxquote = ""
end
