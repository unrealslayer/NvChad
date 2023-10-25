---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<F4>"] = { "<cmd> ClangdSwitchSourceHeader <CR>", "Switch source header" },
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

M.general = {
  n = {
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
}

-- https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
M.debug = {
  n = {
    ["<F5>"] = {
      function()
        require("dap").continue()
      end,
      "continue",
    },
    ["<F10>"] = {
      function()
        require("dap").step_over()
      end,
      "step over",
    },
    ["<F11>"] = {
      function()
        require("dap").step_into()
      end,
      "step into",
    },
    ["<F12>"] = {
      function()
        require("dap").step_out()
      end,
      "step out",
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
  },
}

return M
