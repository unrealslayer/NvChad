local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

---- Настройка фолдов
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99    -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true -- Включаем поддержку фолдов
vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.sessionoptions:append "folds"

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = "*",
  callback = function()
    -- Пересчитать фолды только если не в режиме вставки
    if vim.fn.mode() ~= "i" then
      vim.cmd "normal! zx"
    end
  end,
})

---- Обработка сессий
local session_file = nil

-- Диагностика аргументов
for i, arg in ipairs(vim.v.argv) do
  if arg == "-S" and vim.v.argv[i + 1] then
    session_file = vim.v.argv[i + 1]
    break
  elseif arg:match "^%-S=" then
    session_file = arg:match "^%-S=(.*)"
    break
  end
end

-- Автосохранение сессии при выходе
vim.api.nvim_create_autocmd("VimLeavePre", {
  pattern = "*",
  callback = function()
    -- Убедиться, что session_file определён
    if not session_file then
      return
    end

    -- Формируем полный путь к файлу сессии
    local full_session_file = vim.fn.fnamemodify(session_file, ":p")
    pcall(vim.cmd, "mksession! " .. full_session_file)
  end,
})

---- Конфиг для gitsigns
