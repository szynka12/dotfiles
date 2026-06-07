return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        ols = {
          init_options = {
            enable_comp_lit_signature_help = true,
            enable_overload_resolution = true,
            enable_inlay_hints_params = true,
            enable_inlay_hints_default_params = true,
            enable_inlay_hints_implicit_return = true,
            enable_semantic_tokens = true,
            enable_snippets = true,
            enable_checker_only_saved = true,
            enable_auto_import = true,
            collections = {
              { name = "engine", path = vim.fs.root(0, ".git") .. "engine" },
            },
          },
        },
      },
    },
  },
}
