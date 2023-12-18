-- color scheme
vim.g.tokyonight_style = "moon" -- can be storm, night, or day
lvim.colorscheme = 'tokyonight'

lvim.plugins = {
  {
    "barreiroleo/ltex-extra.nvim",
    config = false, -- run require("neorg").setup()
  },
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
        args = { '-g', '-pdflatex=lualatex', '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
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
