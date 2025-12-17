return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              -- 关掉 Pyright 的这两个检查，交给 Ruff 做，Ruff 更快更好
              diagnosticSeverityOverrides = {
                reportUnusedImport = "none", -- 关掉“未使用导入”
                reportUndefinedVariable = "none", -- 关掉“未定义变量”（Ruff 的 F821 会管）
              },
              typeCheckingMode = "standard", -- 保持标准的类型检查
            },
          },
        },
      },
      ruff = {
        -- 当 LSP 启动时执行此函数
        on_new_config = function(new_config, new_root_dir)
          -- 检查项目根目录下有没有配置文件
          local config_names = { "pyproject.toml", "ruff.toml", ".ruff.toml" }
          local found_config = vim.fs.find(config_names, {
            path = new_root_dir,
            upward = true,
            limit = 1, -- 只要找到一个就行
          })[1]

          -- 如果没找到项目配置，就强行注入你的默认配置路径
          if not found_config then
            -- 这里的 cmd 也可以动态修改，指向你的配置文件
            -- ruff server 支持 --config 参数
            local my_config = vim.fn.stdpath("config") .. "/ruff.toml"

            local cmd = new_config.cmd or { "ruff", "server" }
            table.insert(cmd, "--config")
            table.insert(cmd, my_config)

            new_config.cmd = cmd

            -- (可选) 调试打印，确认生效后可删除
            print(">>> [LSP] Ruff 使用兜底配置: " .. my_config)
          end
        end,
      },
    },
  },
}
