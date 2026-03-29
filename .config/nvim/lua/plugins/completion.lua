return {
  "saghen/blink.cmp",
  opts = {
    snippets = {
      preset = "default",
    },

    sources = {
      -- adding any nvim-cmp sources here will enable them
      -- with blink.compat
      compat = {},
      default = { "lsp", "path", "snippets", "buffer" },
    },

    cmdline = {
      enabled = true,
      keymap = {
        preset = "cmdline",
        ["<Right>"] = false,
        ["<Left>"] = false,
      },
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = function(ctx)
            return vim.fn.getcmdtype() == ":"
          end,
        },
        ghost_text = { enabled = true },
      },
    },

    keymap = {
      preset = "enter",
      ["<C-y>"] = { "select_and_accept" },
    },
  },
}
