---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
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

-- https://github.com/mfussenegger/nvim-dap/blob/master/doc/dap.txt
M.debug = {
  n = {
    ["<leader>du"] = {
      function()
        require("dapui").toggle()
      end,
      "Toggle debug panel",
    },
    ["<F3>"] = {
      function()
        require("dap.ext.vscode").load_launchjs("./.ide/launch.json", { cppdbg = { "c", "cpp" } })
      end,
      "continue",
    },
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
