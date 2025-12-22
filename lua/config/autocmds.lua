-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    -- vim.opt_local.textwidth = 72
    -- vim.opt_local.formatoptions:remove("l")
    -- vim.opt_local.formatoptions:append("aw")
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "vue", "json", "javascript", "typescript" }, -- 针对这些前端文件
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})
