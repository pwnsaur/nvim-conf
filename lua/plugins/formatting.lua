return {
  -- Prettier for formatting
  {
    "prettier/vim-prettier",
    run = "yarn install",
    cmd = "Prettier",
    ft = { "javascript", "typescript", "css", "json", "yaml", "markdown" },
  },
  -- Null-ls for additional formatters and linters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,  -- Python formatter
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.flake8, -- Python linter
        },
      })
    end,
  },
}

