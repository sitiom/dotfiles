if vim.fn.has('win32') == 1 then
  vim.o.shell = 'pwsh'
  vim.o.shellquote = ''
  vim.o.shellpipe= '|'
  vim.o.shellxquote = ''
  vim.o.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command'
  vim.o.shellredir = '| Out-File -Encoding UTF8'
end

