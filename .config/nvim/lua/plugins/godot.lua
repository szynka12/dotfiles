return {
  {
    "Mathijs-Bakker/godotdev.nvim",
    dependencies = { "nvim-lspconfig", "nvim-dap", "nvim-dap-ui", "nvim-treesitter" },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {},
        gdshader_lsp = {},
      },
    },
  },
  { "habamax/vim-godot" },
  {
    "teatek/gdscript-extended-lsp.nvim",
    opts = {
      view_type = "floating",
      picker = "snacks",
      keymaps = {
        declaration = "gd", -- Keymap to go to definition
        close = { "q", "<Esc>" }, -- Keymap for closing the documentation
      },
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          explorer = {
            hidden = true, -- show hidden files
            ignored = false, -- don't show gitignored files
            exclude = { -- exclude specific patterns
              "*.uid", -- glob pattern for files ending with .uid
              "server.pipe", -- exact filename match
            },
          },
        },
      },
    },
  },
}
