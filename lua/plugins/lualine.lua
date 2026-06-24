-- 在文件顶部（return 之前）声明一个变量来缓存 cmp_im
local cmp_im = nil

return {
  "nvim-lualine/lualine.nvim",

  -- (推荐) 添加依赖，确保 cmp_im 在 lualine 之前或同时被加载
  dependencies = { "GkSakari/cmp_im_zhh" },

  -- 将 opts 从一个表 (table) 转换成一个函数 (function)
  opts = function()
    -- 这个函数只会在 lualine 被加载时（VeryLazy 时）执行一次
    -- 在这里 require 一次，并把结果存到我们顶部的变量中
    cmp_im = require("cmp_im")

    -- 返回你原来的配置表
    return {
      sections = {
        lualine_y = {
          { "encoding", separator = " ", padding = { left = 1, right = 1 } },
          { "progress", separator = " ", padding = { left = 0, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
        lualine_x = {
          {
            function()
              return ""
            end,
            color = function()
              -- 现在这里只是访问一个本地变量，速度极快！
              return { fg = cmp_im.getChineseSymbolStatus() and "#A7C080" or "grey" }
            end,
          },
          {
            function()
              return "虎"
            end,
            color = function()
              -- 这里也是！
              return { fg = cmp_im.getStatus() and "#A7C080" or "grey" }
            end,
          },
        },
      },
    }
  end,
}
