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

function vim.getVisualSelection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg "v"
  vim.fn.setreg("v", {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ""
  end
end

M.telescope = {
  plugin = true,

  n = {
    ["<leader>jj"] = {
      function()
        require("telescope.builtin").jumplist {}
      end,
      "Find in jump list",
    },
  },
  v = {
    ["<leader>g"] = {
      function()
        local text = vim.getVisualSelection()
        require("telescope.builtin").live_grep { default_text = text }
      end,
      "Live grep",
    },
    ["<leader>f"] = {
      function()
        local text = vim.getVisualSelection()
        require("telescope.builtin").find_files { default_text = text }
      end,
      "Find files",
    },
    ["<leader>gl"] = {
      function()
        require("telescope.builtin").git_commits()
      end,
      "Git log (Telescope)",
    },
  },
}

M.marks = {
  plugin = true,

  n = {
    -- Добавление аннотации к метке
    ["m'"] = {
      function()
        require("marks").annotate()
      end,
      "Добавить аннотацию к метке",
    },
  },
}

M.undotree = {
  plugin = true,

  n = {
    ["<leader>u"] = { ":UndotreeToggle<CR>", "Toggle UndoTree" },
  },
}

M.tabs = {
  plugin = false,

  n = {
    ["<leader>te"] = { ":tabnew<CR>", "New tab" },
    ["<leader>tc"] = { ":tabclose<CR>", "Close tab" },
    ["<leader>tp"] = { ":tabprevious<CR>", "Prev tab" },
    ["<leader>tn"] = { ":tabnext<CR>", "Next tab" },
  },
}

M.split = {
  plugin = false,

  n = {
    ["<leader>sh"] = { ":sp<CR>", "Horizontal split" },
    ["<leader>sv"] = { ":vsp<CR>", "Vertical split" },
    ["<leader>sc"] = { ":close<CR>", "Close split" },
    ["<leader>se"] = { "<C-w>=", "Balance sizes" },
    ["<leader>s>"] = {
      function()
        vim.cmd "vertical resize +5"
      end,
      "Increase width",
    },
    ["<leader>s<"] = {
      function()
        vim.cmd "vertical resize -5"
      end,
      "Decrease width",
    },
    ["<leader>s+"] = {
      function()
        vim.cmd "resize +5"
      end,
      "Increase height",
    },
    ["<leader>s-"] = {
      function()
        vim.cmd "resize -5"
      end,
      "Decrease height",
    },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    ["<leader>hs"] = {
      function()
        require("gitsigns").stage_hunk()
      end,
      "Stage hunk",
    },
    ["<leader>hr"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },
    ["<leader>gp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },
    ["<leader>gb"] = {
      function()
        require("gitsigns").blame_line { full = true }
      end,
      "Blame line (full)",
    },
    ["<leader>gB"] = {
      function()
        require("gitsigns").toggle_current_line_blame()
      end,
      "Toggle current line blame",
    },
    ["<leader>ga"] = {
      function()
        -- Получаем абсолютный путь к текущему файлу
        local filepath = vim.fn.expand "%:p"
        if filepath == "" then
          vim.notify("No file is currently open.", vim.log.levels.ERROR)
          return
        end

        -- Сохраняем текущую директорию
        local original_dir = vim.fn.getcwd()

        -- Переходим в директорию текущего файла
        local file_dir = vim.fn.fnamemodify(filepath, ":h")
        vim.cmd("cd " .. vim.fn.fnameescape(file_dir))

        -- Проверяем, является ли текущая директория частью Git-репозитория
        local git_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
        if vim.v.shell_error ~= 0 then
          vim.cmd("cd " .. vim.fn.fnameescape(original_dir)) -- Возвращаемся в исходную директорию
          vim.notify("This is not a Git repository.", vim.log.levels.ERROR)
          return
        end

        -- Определяем относительный путь файла относительно корня репозитория
        local relative_path = vim.fn.fnamemodify(filepath, ":.")
        local is_tracked = vim.fn.system("git ls-files --error-unmatch " .. vim.fn.shellescape(relative_path))
        if vim.v.shell_error ~= 0 then
          vim.cmd("cd " .. vim.fn.fnameescape(original_dir)) -- Возвращаемся в исходную директорию
          vim.notify("File is not tracked by Git: " .. relative_path, vim.log.levels.ERROR)
          return
        end

        -- Выполняем git blame для всего файла
        local output = vim.fn.system("git blame " .. vim.fn.shellescape(relative_path))
        if vim.v.shell_error ~= 0 then
          vim.cmd("cd " .. vim.fn.fnameescape(original_dir)) -- Возвращаемся в исходную директорию
          vim.notify("Failed to run git blame on the file.", vim.log.levels.ERROR)
          return
        end

        -- Возвращаемся в исходную директорию
        vim.cmd("cd " .. vim.fn.fnameescape(original_dir))

        -- Открываем плавающее окно для отображения
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_open_win(buf, true, {
          relative = "editor",
          width = math.floor(vim.o.columns * 0.8),
          height = math.floor(vim.o.lines * 0.8),
          row = math.floor(vim.o.lines * 0.1),
          col = math.floor(vim.o.columns * 0.1),
          style = "minimal",
          border = "rounded",
        })

        -- Устанавливаем содержимое буфера
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n"))
        -- Добавляем управление окном
        vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { noremap = true, silent = true })
      end,
      "Blame for the whole file",
    },
    ["<leader>gd"] = {
      function()
        require("gitsigns").diffthis()
      end,
      "Diff against HEAD",
    },
    ["<leader>gh"] = {
      function()
        require("gitsigns").diffthis "~1"
      end,
      "Diff against previous revision",
    },
    ["[c"] = {
      function()
        require("gitsigns").prev_hunk()
      end,
      "Previous hunk",
    },
    ["]c"] = {
      function()
        require("gitsigns").next_hunk()
      end,
      "Next hunk",
    },
  },

  v = {
    ["<leader>hs"] = {
      function()
        require("gitsigns").stage_hunk { vim.fn.line ".", vim.fn.line "v" }
      end,
      "Stage selected hunk",
    },
    ["<leader>hr"] = {
      function()
        require("gitsigns").reset_hunk { vim.fn.line ".", vim.fn.line "v" }
      end,
      "Reset selected hunk",
    },
  },
}

return M
