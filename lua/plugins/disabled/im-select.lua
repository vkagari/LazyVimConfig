-- TODO: 不适用于Rime
return {
  "brglng/vim-im-select",
  config = function()
    require("plugins.im-select")
  end,
  cmd = "ImSelectEnable",
  keys = {
    { "<leader>um", "<cmd>ImSelectEnable<cr>", desc = "Enable Im-Select" },
    { "<leader>uM", "<cmd>ImSelectDisable<cr>", desc = "Disable Im-Select" },
  },
  init = function()
    vim.g.im_select_command = "D:/Tools/im-select.exe"
    vim.g.im_select_default = "1033"
    vim.g.im_select_enable_focus_events = 0
    vim.g.im_select_enable_cmd_line = 0
  end,
}
