-- color scheme
vim.g.tokyonight_style = "moon" -- can be storm, night, or day
lvim.colorscheme = 'tokyonight'

lvim.plugins = {
  {
    "barreiroleo/ltex-extra.nvim",
    config = false, -- run require("neorg").setup()
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true
  },
  {
    'mkropat/vim-ezguifont'
  },
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },
  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    config = true
  },
  { "danymat/neogen", config = true },
}

require("lvim.lsp.manager").setup("ltex", {
  on_attach = function(client, bufnr)
    -- rest of your on_attach process.
    require("ltex_extra").setup {
      load_langs = { "en-GB" },
      path = ".ltex"
    }
  end,
  settings = {
    ltex = {
      language = "en-GB",
    },
  },
}
)

vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "texlab" })

require("lvim.lsp.manager").setup("texlab", {
  cmd = { 'texlab' },
  filetypes = { 'tex', 'plaintex', 'bib' },
  -- root_dir = util.root_pattern('.latexmkrc', '.git'),
  single_file_support = true,
  settings = {
    texlab = {
      rootDirectory = nil,
      build = {
        executable = 'latexmk',
        args = { '-g', '-pdflatex=lualatex', '-shell-escape', '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
        onSave = false,
        forwardSearchAfter = false,
      },
      forwardSearch = {
        executable = "zathura",
        args = { "--synctex-forward", "%l:1:%f", "%p" },
      },
      chktex = {
        onOpenAndSave = true,
        onEdit = true,
      },
      diagnosticsDelay = 300,
      latexFormatter = 'latexindent',
      latexindent = {
        ['local'] = nil, -- local is a reserved keyword
        modifyLineBreaks = false,
      },
      bibtexFormatter = 'texlab',
      formatterLineLength = 80,
    },
  }

})


local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    name = "black",
    extra_args = { "--preview", "--line-length", 79 },
    filetypes = { "python" }
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { name = "flake8" },
  {
    name = "shellcheck",
    args = { "--severity", "warning" },
  },
}

vim.keymap.set('n', 'k', function() return vim.v.count == 0 and 'gk' or 'k' end, { expr = true })
vim.keymap.set('n', 'j', function() return vim.v.count == 0 and 'gj' or 'j' end, { expr = true })
lvim.builtin.which_key.mappings["lo"] = {
  "<cmd>Outline<CR>", "Projects"
}

if vim.fn.has("gui_running") then
  vim.opt.guifont = "FiraCode Nerd Font Ret:h12:w53"
  lvim.keys.normal_mode["<C-=>"] = ":IncreaseFont<CR>"
  lvim.keys.normal_mode["<C-+>"] = ":IncreaseFont<CR>"
  lvim.keys.normal_mode["<C-0>"] = ":ResetFontSize<CR>"
  lvim.keys.normal_mode["<C-->"] = ":DecreaseFont<CR>"
end
