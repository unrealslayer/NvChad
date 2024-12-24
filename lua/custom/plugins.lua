local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options
  {
    "mbbill/undotree",
    lazy = false, -- Плагин будет загружаться сразу
    keys = {      -- Настройка горячих клавиш
      { "<leader>u", ":UndotreeToggle<CR>", desc = "Toggle UndoTree" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2       -- Размещение окна: вертикально
      vim.g.undotree_SplitWidth = 40        -- Ширина окна
      vim.g.undotree_DiffpanelHeight = 15   -- Высота панели diff
      vim.g.undotree_SetFocusWhenToggle = 1 -- Переключать фокус на окно Undotree
    end,
  },
  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      require("marks").setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- disables mark tracking for specific buftypes. default {}
        excluded_buftypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = true,
        },
        mappings = {
          annotate = "m'", -- Добавление аннотации к текущей метке
        },
      }
    end,
  },
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

  -- {
  --   "kevinhwang91/nvim-ufo",
  --   event = "BufReadPost",
  --   dependencies = {
  --     "kevinhwang91/promise-async",
  --     "nvim-treesitter/nvim-treesitter",
  --   },
  --   init = function()
  --     vim.o.foldenable = true
  --     vim.o.foldcolumn = "0" --"auto:9"
  --     vim.o.foldlevel = 99
  --     vim.o.foldlevelstart = 99
  --     vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldclose:]]
  --   end,
  --   opts = {
  --     provider_selector = function()
  --       return { "treesitter", "indent" }
  --     end,
  --   },
  -- },

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

require("gitsigns").setup {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  signcolumn = true,
  numhl = true,               -- Подсветка номеров строк
  linehl = false,             -- Подсветка всей строки
  current_line_blame = false, -- Blame текущей строки
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- Текст у конца строки
    delay = 100,           -- Задержка показа blame
    ignore_whitespace = false,
  },
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
}

return plugins
