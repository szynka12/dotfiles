-- color scheme
vim.g.tokyonight_style = "moon" -- can be storm, night, or day
lvim.colorscheme = 'tokyonight'

require("lvim.lsp.manager").setup("ltex", {
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
        args = { '-pdflatex=lualatex', '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
        onSave = false,
        forwardSearchAfter = false,
      },
      auxDirectory = '.',
      forwardSearch = {
        executable = nil,
        args = {},
      },
      chktex = {
        onOpenAndSave = false,
        onEdit = false,
      },
      diagnosticsDelay = 300,
      latexFormatter = 'latexindent',
      latexindent = {
        ['local'] = nil,   -- local is a reserved keyword
        modifyLineBreaks = false,
      },
      bibtexFormatter = 'texlab',
      formatterLineLength = 80,
    },
  }

})
