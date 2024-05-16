local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- vim figutive
  {
    "tpope/vim-fugitive",
    lazy = false,
  },

  -- vim diff
  {
    "sindrets/diffview.nvim",
    lazy = false,
    config = function()
      require("diffview").setup {
        view = {
          merge_tool = {
            -- Config for conflicted files in diff views during a merge or rebase.
            layout = "diff3_mixed",
            disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
            winbar_info = true,         -- See ':h diffview-config-view.x.winbar_info'
          },
        },
      }
    end,
  },

  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      -- "ibhagwan/fzf-lua", -- optional
    },
    config = true,
    lazy = false,
  },

  -- transparent background
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    config = function()
      require("transparent").setup { -- Optional, you don't have to run setup.
        groups = {                   -- table: default groups
          "Normal",
          "NormalNC",
          "Comment",
          "Constant",
          "Special",
          "Identifier",
          "Statement",
          "PreProc",
          "Type",
          "Underlined",
          "Todo",
          "String",
          "Function",
          "Conditional",
          "Repeat",
          "Operator",
          "Structure",
          "LineNr",
          "NonText",
          "SignColumn",
          "CursorLineNr",
          "EndOfBuffer",
        },
        extra_groups = {
          "NormalFloat",     -- plugins which have float panel such as Lazy, Mason, LspInfo
          "NvimTreeNormal",  -- NvimTree
        },
        exclude_groups = {}, -- table: groups you don't want to clear
      }
    end,
  },

  -- neodev
  {
    "folke/neodev.nvim",
    lazy = false,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
      },
    },
  },

  --nvim dap
  {
    "mfussenegger/nvim-dap",
    lazy = true,
    config = function()
      vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

      require("dap").adapters.lldb = {
        type = "executable",
        command = "/usr/local/bin/lldb-vscode", -- adjust as needed
        name = "lldb",
      }
    end,
  },

  -- nvim dap ui
  {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    dependencies = {
      {
        "mfussenegger/nvim-dap",
      },
      {
        "folke/neodev.nvim",
      },
      {
        "nvim-neotest/nvim-nio",
      },
    },
    config = function()
      require("neodev").setup {
        library = { plugins = { "nvim-dap-ui" }, types = true },
      }
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- mason nvim dap
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },

  {
    "theHamsta/nvim-dap-virtual-text",
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
