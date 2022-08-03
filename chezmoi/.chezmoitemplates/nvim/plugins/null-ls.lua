local null_ls = require "null-ls"
local b = null_ls.builtins

local M = {}

M.sources = {
  b.diagnostics.actionlint,
  b.formatting.stylua,
  b.diagnostics.selene,
}

return M
