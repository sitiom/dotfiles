return {
  symbol_map = {
    Copilot = "",
  },
  before = function(entry, vim_item)
    if entry.source.name == "copilot" then
      vim_item.kind = "Copilot"
      vim_item.kind_hl_group = "CmpItemKindCopilot"
    end
    return vim_item
  end,
}
