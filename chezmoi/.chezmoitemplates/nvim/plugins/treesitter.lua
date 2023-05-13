return {
  "nvim-treesitter/nvim-treesitter",
  cond = not vim.g.vscode,
  dependencies = {
    {
      "andymass/vim-matchup",
      init = function() vim.g.matchup_matchparen_deferred = 1 end,
    },
    "mrjones2014/nvim-ts-rainbow",
  },
  opts = {
    auto_install = vim.fn.executable "tree-sitter" == 1,
    matchup = { enable = true },
    rainbow = { enable = true },
  },
}
