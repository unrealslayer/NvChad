---@type MappingsTable
local M = {}

-- <C-*> = CTRL + *, <S-*> = SHIFT + *, <M-*> = ALT + *

M.general = {
  n = {
    ["<F4>"] = { "<cmd> ClangdSwitchSourceHeader <CR>", "Switch source header" },
    ["zz"] = {
      function()
        require("lazy").home()
      end,
      "Open lazy",
    },
    ["tg"] = {
      function()
        require("transparent").toggle()
      end,
      "Toggle transparent background",
    },
  },
  i = {
    ["<F4>"] = { "<cmd> ClangdSwitchSourceHeader <CR>", "Switch source header" },
  },
  v = {
    ["<F4>"] = { "<cmd> ClangdSwitchSourceHeader <CR>", "Switch source header" },
  },
}

M.lspconfig = {
  n = {
    ["<F2>"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },
  },
}

M.git = {
  n = {
    ["<leader>gh"] = {
      "<cmd> DiffviewFileHistory <CR>",
      "Show file history",
    },
    ["<leader>gg"] = {
      "<cmd> Neogit <CR>",
      "Open neogit",
    },
    ["<leader>gf"] = {
      "<cmd> DiffviewOpen <CR>",
      "Open diff view",
    },
    ["<leader>gc"] = {
      "<cmd> DiffviewClose <CR>",
      "Close file history",
    },
    ["<leader>gp"] = {
      "<cmd> Git checkout - <CR>",
      "Git checkout -",
    },
  },
}

-- https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
M.debug = {
  n = {
    ["<leader>du"] = {
      function()
        require("dapui").toggle()
      end,
      "Toggle debug panel",
    },
    ["<leader>b"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "Toggle breakpoint",
    },
    ["<leader>B"] = {
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      "Add breakpoint with condition",
    },
    ["<leader>dl"] = {
      function()
        require("dap").run_last()
      end,
      "Restart debugger",
    },
    ["<F3>"] = {
      function()
        require("dapui").toggle()
        require("dap.ext.vscode").load_launchjs(
          vim.fn.getcwd() .. "/scripts/launch.json",
          { lldb = { "c", "cpp", "hpp" } }
        )
      end,
      "Launch debug",
    },
    ["<F5>"] = {
      function()
        require("dap.ext.vscode").load_launchjs(
          vim.fn.getcwd() .. "/scripts/launch.json",
          { lldb = { "c", "cpp", "hpp" } }
        )
        require("dap").continue()
      end,
      "Continue",
    },
    ["<F10>"] = {
      function()
        require("dap").step_over()
      end,
      "Step over",
    },
    ["<F11>"] = {
      function()
        require("dap").step_into()
      end,
      "Step into",
    },
    ["<F23>"] = { -- Shift + F11
      function()
        require("dap").step_out()
      end,
      "Step out",
    },
  },
}

M.mason = {
  n = {
    ["<leader>mm"] = {
      "<cmd> Mason <CR>",
      "Open mason",
    },
  },
}

M.git = {
  n = {
    ["<leader>gh"] = {
      "<cmd> DiffviewFileHistory <CR>",
      "Show file history",
    },
    ["<leader>gg"] = {
      "<cmd> Neogit <CR>",
      "Open neogit",
    },
    ["<leader>gf"] = {
      "<cmd> DiffviewOpen <CR>",
      "Open diff view",
    },
    ["<leader>gc"] = {
      "<cmd> DiffviewClose <CR>",
      "Close file history",
    },
    ["<leader>gp"] = {
      "<cmd> Git checkout - <CR>",
      "Git checkout -",
    },
  },
}

return M
