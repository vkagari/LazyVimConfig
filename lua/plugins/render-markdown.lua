return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = true,
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    pipe_table = {
      enabled = true,
      preset = "round", -- 使用圆角边框，视觉上更接近现代 UI
      style = "full", -- 渲染完整的边框
      cell = "trimmed", -- 自动修剪单元格空格
      alignment_indicator = true, -- 显示对齐方式
    },
    -- 必须确保 conceal 开启
    win_options = {
      conceallevel = { default = 2, rendered = 2 },
      concealcursor = { default = "nc", rendered = "nc" },
    },
  },
}
