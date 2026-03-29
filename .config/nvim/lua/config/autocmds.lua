-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown", "tex" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- proper tab settings for gdscript
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gdscript" },
  callback = function()
    vim.bo.sw = 4
    vim.bo.sts = 4
    vim.bo.ts = 4
    vim.bo.expandtab = false
    vim.bo.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("gmsh_file"),
  pattern = { "*.geo" },
  callback = function()
    vim.bo.filetype = "gmsh"
  end,
})

-- Features for working with odin lang
local odin_source = vim.fn.system("odin root")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "odin" },
  callback = function()
    -- Grep the libraries
    vim.api.nvim_create_user_command("GrepOdinLibs", function()
      local s = require("snacks")
      s.picker.grep({
        filetype = "odin",
        dirs = { odin_source .. "/core", odin_source .. "/base", odin_source .. "/vendor" },
      })
    end, {})

    vim.keymap.set("n", "<Leader>cO", ":GrepOdinLibs<CR>", { noremap = true })

    -- Create custom surrounding for derefencing and converting to a pointer
    vim.b.minisurround_config = {
      custom_surroundings = {
        -- dereference
        ["^"] = {
          output = { left = "(", right = ")^" },
        },
        -- pointer
        ["&"] = {
          output = { left = "&(", right = ")" },
        },
      },
    }
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = { odin_source .. "*" },
  callback = function()
    vim.bo.readonly = true
    vim.bo.modifiable = false
  end,
})
