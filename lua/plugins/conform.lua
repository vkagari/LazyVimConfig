return {
  "stevearc/conform.nvim",

  event = { "BufWritePre" },
  cmd = { "Conform", "ConformInfo" },

  opts = {
    formatters = {
      ruff_format = {
        args = function(self, ctx)
          local config_names = { "pyproject.toml", "ruff.toml", ".ruff.toml" }

          local found_config = vim.fs.find(config_names, {
            path = ctx.dirname,
            upward = true,
            stop = vim.uv.os_homedir(),
          })[1]

          local default_args = { "format", "--force-exclude", "--stdin-filename", "$FILENAME", "-" }

          if found_config then
            -- A. 如果找到了项目配置，就用默认参数（完全尊重项目）
            return default_args
          else
            -- B. 如果没找到，就追加 "--config" 参数指向你的默认文件
            -- stdpath("config") 会自动获取你的 nvim 配置目录路径（跨平台）
            local my_default_config = vim.fn.stdpath("config") .. "/ruff.toml"

            -- 将 --config 加入参数表
            -- 注意：Table 连接在 Lua 里比较繁琐，这里直接列出
            return {
              "format",
              "--force-exclude",
              "--config",
              my_default_config,
              "--stdin-filename",
              "$FILENAME",
              "-",
            }
          end
        end,
      },
    },
    formatters_by_ft = {
      yaml = { "prettier" },
      lua = { "stylua" },
      python = { "ruff_fix", "ruff_format" },
    },

    async = true,
    log_level = vim.log.levels.INFO,
  },
}
