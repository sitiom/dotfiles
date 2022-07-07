local M = {}

M.setup_lsp = function(attach, capabilities)
   if vim.g.vscode then
      return
   end

   local lspconfig = require "lspconfig"

   local servers = { "html", "cssls", "clangd" }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
      }
   end
end

return M
