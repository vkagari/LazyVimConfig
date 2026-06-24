return {
  {
    "gksakari/toggleterm.nvim",
    lazy = false,
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      direction = "float",
      shade_filetypes = {},
      hide_numbers = true,
      insert_mappings = true,
      terminal_mappings = true,
      start_in_insert = true,
      close_on_exit = true,
      autochdir = true,
      float_opts = {
        border = "curved",
      },
    },
    keys = {
      { "<c-\\>", ":ToggleTerm direction=horizontal<C-b>", desc = "New Horizontal Terminal" },
      { "<space>th", ":ToggleTerm direction=horizontal<C-b>", desc = "New Horizontal Terminal" },
      { "<space>tH", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Horizontal Terminal" },
      { "<space>tv", ":ToggleTerm direction=vertical<C-b>", desc = "New Vertical Terminal" },
      { "<space>tV", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Vertical Terminal" },
      { "<space>tt", ":ToggleTerm direction=tab<C-b>", desc = "New Tab Terminal" },
      { "<space>tT", "<cmd>ToggleTerm direction=tab<cr>", desc = "Tab Terminal" },
      { "<space>tf", ":ToggleTerm direction=float<C-b>", desc = "New Float Terminal" },
      { "<space>tF", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
      {
        "<leader>gg",
        function()
          local Terminal = require("toggleterm.terminal").Terminal
          local lazygit = Terminal:new({ cmd = "lazygit", direction = "float", hidden = true })
          lazygit.dir = LazyVim.root.git()
          lazygit:toggle()
        end,
        desc = "Lazygit",
      },
    },
  },
}
