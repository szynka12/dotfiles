-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Snacks animations
-- Set to `false` to globally disable all snacks animations
vim.g.snacks_animate = true
vim.g.ai_cmp = false

vim.g.python3_host_prog = vim.fn.expand("~/.virtualenvs/neovim/bin/python3")

if vim.g.neovide then
  vim.o.guifont = "Hack Nerd Font:h14"
  vim.g.neovide_opacity = 0.975
  vim.g.neovide_normal_opacity = 0.975
  vim.g.neovide_underline_stroke_scale = 1.0
  vim.g.neovide_cursor_animation_length = 0.0

  local function scale_font(amount)
    local temp = vim.g.neovide_scale_factor + amount

    if temp < 0.5 then
      return
    end

    vim.g.neovide_scale_factor = temp
  end

  -- font size adjustment
  -- Below is the solution from https://github.com/neovide/neovide/discussions/2301
  -- vim.keymap.set({ "n", "v" }, "<C-=>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  -- vim.keymap.set({ "n", "v" }, "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "<C-=>", function()
    scale_font(0.1)
  end)
  vim.keymap.set({ "n", "v" }, "<C-->", function()
    scale_font(-0.1)
  end)
  vim.keymap.set({ "n", "v" }, "<C-+>", function()
    vim.g.neovide_scale_factor = 1
  end)
end
