---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<F4>"] = {"<cmd> ClangdSwitchSourceHeader <CR>", "Switch source header"}
  },
  i = {
    ["<F4>"] = {"<cmd> ClangdSwitchSourceHeader <CR>", "Switch source header"}
  },
  v = {
    ["<F4>"] = {"<cmd> ClangdSwitchSourceHeader <CR>", "Switch source header"}
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

-- more keybinds!

return M
