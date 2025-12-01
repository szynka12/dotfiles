return {
  {
    "barreiroleo/ltex_extra.nvim",
    branch = "dev",
    ft = { "markdown", "tex" },
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      load_langs = { "en-GB" },
      path = ".ltex",
      server_opts = {
        settings = {
          ltex = {
            settings = {
              language = "en-GB",
            },
          },
        },
      },
    },
  },
  -- server settings
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ltex = {
          -- filetypes = {
          --   "bib",
          --   "gitcommit",
          --   "latex",
          --   "mail",
          --   "markdown",
          --   "norg",
          --   "org",
          --   "pandoc",
          --   "rst",
          --   "tex",
          --   "text",
          -- },
          settings = {
            -- https://valentjn.github.io/ltex/settings.html
            ltex = {
              -- trace = { server = "verbose" },
              checkFrequency = "save",
              language = "en-GB",
              -- additionalRules = {
              --   enablePickyRules = true,
              --   motherTongue = "fr",
              -- },
              -- https://community.languagetool.org/rule/list?lang=en
              -- disabledRules = {
              --   -- en-GB disabled rules loaded from ~/.config/nvim/spell/ltex.disabledRules.en-GB.txt
              --   ["fr"] = { "APOS_TYP", "FRENCH_WHITESPACE", "FR_SPELLING_RULE", "COMMA_PARENTHESIS_WHITESPACE" },
              -- },
            },
          },
        },
      },
    },
  },
}
