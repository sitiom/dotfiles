return {
  settings = {
    yaml = {
      schemas = {
        ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
        ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      },
    },
  },
}
