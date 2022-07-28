return {
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = function(entry, vim_item)
      if entry.source.name == "copilot" then
        vim_item.kind = ""
        vim_item.kind_hl_group = "CmpItemKindCopilot"
        return vim_item
      end
      return require("lspkind").cmp_format { with_text = false, maxwidth = 50 }(entry, vim_item)
    end,
  },
  source_priority = {
    copilot = 5000,
  },
}
