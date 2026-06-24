return {
  "GkSakari/cmp_im_zhh",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-cmdline",
  },
  init = function()
    local cmp = require("cmp")
    local cmp_im = require("cmp_im")
    cmp.setup({
      mapping = {
        ["<Space>"] = cmp.mapping(cmp_im.select(), { "i" }),
        ["<CR>"] = cmp.mapping(cmp_im.confirmEnter(), { "i" }),
      },
      sources = cmp.config.sources({
        { name = "IM" },
      }, {
        { name = "lazydev" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "buffer" },
      }),
      enabled = function()
        local filetype = vim.api.nvim_buf_get_option(0, "filetype")
        if filetype == "TelescopePrompt" then
          return require("cmp_im").getStatus()
        end
        return true
      end,
    })
    -- `/` cmdline setup.
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline({
        ["<Space>"] = {
          c = function(fallback)
            local cmp_im = require("cmp_im")
            if cmp_im.getStatus() and cmp.visible() then
              local entries = cmp.get_entries()
              if #entries > 0 and entries[1].source.name == "IM" then
                return cmp.confirm({ select = true })
              end
            end
            return fallback()
          end,
        },
      }),
      sources = {
        { name = "IM" },
        { name = "buffer" },
      },
    })
    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline({
        ["<Space>"] = {
          c = function(fallback)
            local cmp_im = require("cmp_im")
            if cmp_im.getStatus() and cmp.visible() then
              local entries = cmp.get_entries()
              if #entries > 0 and entries[1].source.name == "IM" then
                return cmp.confirm({ select = true })
              end
            end
            return fallback()
          end,
        },
      }),
      sources = require("cmp").config.sources({
        { name = "IM" },
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
  end,
  keys = {
    {
      mode = "n",
      "<leader>cn",
      function()
        vim.notify(string.format(require("cmp_im").toggle() and "虎码启动" or "虎码退出"))
      end,
      desc = "切换虎码",
    },
    {
      mode = { "n", "v", "c", "i" },
      "<M-;>",
      function()
        vim.notify(string.format(require("cmp_im").toggle() and "虎码启动" or "虎码退出"))
      end,
      desc = "切换虎码",
    },
  },
}
