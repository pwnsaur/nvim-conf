return {
  -- Debugging with nvim-dap
  {
    "mfussenegger/nvim-dap",
    event = "BufReadPre",
    config = function()
      local dap = require("dap")
      -- Add configurations here for different languages
      dap.adapters.python = {
        type = 'executable',
        command = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python',
        args = { '-m', 'debugpy.adapter' },
      }
      dap.configurations.python = {
        {
          type = 'python';
          request = 'launch';
          name = "Launch file";
          program = "${file}";
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"  -- Add this line to include nvim-nio
    },
    config = function()
      require("dapui").setup()
    end
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio"  -- Add this line to include nvim-nio
    },
    config = function()
      require("dap-go").setup()
    end
  },
  -- Add nvim-nio as a separate plugin entry
  {
    "nvim-neotest/nvim-nio"
  }
}
