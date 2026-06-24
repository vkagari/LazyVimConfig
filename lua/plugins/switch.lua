return {
  "AndrewRadev/switch.vim",
  lazy = true,
  cmd = { "Switch", "SwitchReverse", "SwitchExtend" },
  keys = { { mode = "n", "<leader>o", "<cmd>Switch<cr>", desc = "Switch" } },
  config = function()
    vim.g.switch_custom_definitions = {
      vim.fn["switch#NormalizedCaseWords"]({ "yes", "no" }),
      vim.fn["switch#NormalizedCaseWords"]({ "single", "double" }),
      vim.fn["switch#Words"]({ "1", "0" }),
    }
  end,
}
