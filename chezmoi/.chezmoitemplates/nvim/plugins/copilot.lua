return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    dependencies = "zbirenbaum/copilot-cmp",
    config = function() require("copilot").setup {} end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function() require("copilot_cmp").setup() end,
    opts = {
      suggestion = { enabled = false },
      panel = { enabled = false },
    },
  },
}
