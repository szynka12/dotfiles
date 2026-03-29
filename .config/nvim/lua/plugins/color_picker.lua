local odin_raylib_colors = {
  priority = 1,
  format = "raw_rgb",
  ft = { "odin" },
  -- Pattern reference at https://www.lua.org/manual/5.4/manual.html#6.4.1
  -- rl.Color{165, 123, 162, 184}

  -- Pattern list
  "Color%{()[%d.,%s]+()%}", -- Gets `.1,.2,.3` from code `vec3(.1,.2,.3)`
}

local M = {
  "eero-lehtinen/oklch-color-picker.nvim",
  event = "VeryLazy",
  version = "*",
  keys = {
    {
      "<leader>v",
      function()
        require("oklch-color-picker").pick_under_cursor()
      end,
      desc = "Color pick under cursor",
    },
  },

  opts = {
    highlight = {
      style = "virtual_left",
      virtual_text = " ■ ",
      disable_builtin_lsp_colors = true,
    },
    enabled_lsps = { "ols" },
    patterns = {

      numbers_in_brackets = false,

      -- #000000
      hex = { priority = -1, "()#%x%x%x+%f[%W]()" },
      hex_literal = { priority = -1, "()0x%x%x%x%x%x%x+%f[%W]()" },

      odin_raylib_colors = odin_raylib_colors,
    },
  },
}

return M
