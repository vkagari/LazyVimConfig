-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
local del = vim.keymap.del

-- map("i", "jk", "<Esc>")
map("i", ";j", "<Esc>")
del("i", "<M-j>")
del("i", "<M-k>")
map("i", "<M-j><M-k>", "<Esc>")

-- 取消高亮
map("n", "<leader>nh", ":nohl<CR>")

-- 快速编译
map("n", "<F4>", ":!clang++ *.cpp<CR>")
map("n", "<C-F4>", ":!clang++ -g *.cpp<CR>")

-- window
map("n", "<leader>ww", "<C-w>w", { desc = "Other Window" })
map("n", "<leader>wo", "<C-w>o", { desc = "Close all other windows" })
map("n", "<leader>wx", "<C-w>x", { desc = "Swap current with next" })
map("n", "<leader>wt", "<C-w>T", { desc = "Break out into a new tab" })

-- tabs
map("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabe %<cr>", { desc = "New tab" })
map("n", "<leader><tab>o", "<cmd>tabonly<cr>", { desc = "Close all other tabs" })

-- 增加新行
map("n", "<CR>", "o<Esc>")

-- 全选
-- map("n", "<C-a>", "GVgg")
-- map({ "v", "i" }, "<C-a>", "<esc>GVgg")

map("n", "<C-y>", "GVggy<C-o><C-o>")
map("v", "<C-y>", "<esc>GVggy<C-o><C-o>")
map("i", "<C-y>", "<esc>GVggy<C-o><C-o>i")

-- 打开终端
del("n", "<leader>ft")
del("n", "<leader>fT")
-- map("n", "<C-_>", "<cmd>ToggleTerm<cr>")

local float_terminal
local function toggle_float_terminal()
  local Terminal = require("toggleterm.terminal").Terminal
  float_terminal = float_terminal or Terminal:new({ direction = "float", hidden = true })
  float_terminal:toggle()
end

-- Cover both the traditional <C-_> control byte and the distinct <C-/>
-- keycode emitted by terminals that support an extended keyboard protocol.
for _, key in ipairs({ "<C-/>", "<C-_>" }) do
  map({ "n", "i", "t" }, key, toggle_float_terminal, { desc = "Toggle Float Terminal" })
end

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  map("t", "<esc><esc>", [[<C-\><C-n>]], opts)
  map("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  map("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  map("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  map("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  map("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
  map("t", "<MouseMove>", "<NOP>")
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

map("x", "<C-c>", '"+y')
map({ "n", "x" }, "gp", '"0p', { desc = "Paste from last yanked" })
map({ "n", "x" }, "gP", '"0P', { desc = "Paste from last yanked" })

-- 切换config文件中的配置项
-- 定义一个函数来切换行首字符
local function toggle_comment()
  -- 获取当前光标所在行
  -- local row = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_get_current_line()

  -- 检查第一个字符并执行相应操作
  if line:match("^#") then
    -- 如果是 #，替换为空格
    line = line:gsub("^#", " ")
  elseif line:match("^ ") then
    -- 如果是空格，替换为 #
    line = line:gsub("^ ", "#")
  else
    -- 否则在前面增加一个 #
    line = "#" .. line
  end

  -- 设置当前行的新内容
  vim.api.nvim_set_current_line(line)
end

-- 为特定文件类型设置键位映射
vim.api.nvim_create_autocmd("FileType", {
  pattern = "confini", -- 替换为你需要的文件类型
  callback = function()
    map("n", "<leader>m", toggle_comment, { desc = "Toggle Config", noremap = true, buffer = true })
  end,
})
