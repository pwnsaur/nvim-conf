return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local parsers = require("nvim-treesitter.parsers")

      -- Ensure the 'lua' and 'python' parsers are installed
      if not parsers.has_parser("lua") then
        vim.cmd("TSInstall lua")
      end
      if not parsers.has_parser("python") then
        vim.cmd("TSInstall python")
      end

      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "vimdoc", "query", "rust", "typescript", "javascript", "python" },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        modules = {},          -- Add this line
        ignore_install = {},   -- Add this line
      })
    end,
  },
}

