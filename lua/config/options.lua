-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.autoformat = false

vim.opt.statuscolumn = [[%!v:lua.LazyVim.statuscolumn()]]
vim.opt.colorcolumn = "100"

-- LazyVim sets `nowrap` in its defaults after this file is read, so apply this
-- after startup and make it the default for subsequent windows as well.
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.breakindent = true
  end,
})

-- Let WhichKey take over leader sequences immediately.
vim.opt.timeoutlen = 100

-- Writing source should remain literal text rather than rendered/concealed symbols.
local writing_source = vim.api.nvim_create_augroup("literal-writing-source", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = writing_source,
  pattern = { "tex", "plaintex", "typst" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})
