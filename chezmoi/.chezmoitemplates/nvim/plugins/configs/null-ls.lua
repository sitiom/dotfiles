local null_ls = require "null-ls"
local b = null_ls.builtins

local sources = {
   b.formatting.prettierd,
   b.formatting.stylua,
   b.formatting.shfmt,

   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },
}

local M = {}

M.setup = function()
   null_ls.setup {
      sources = sources,
   }
end

return M
