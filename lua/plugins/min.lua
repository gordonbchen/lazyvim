return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "min",
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      -- No indentation or current-scope guide lines in the editing window.
      indent = { enabled = false },
      scope = { enabled = false },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- LazyVim's "enter" preset accepts a visible completion on <Enter>.
        -- Keep ordinary writing keys ordinary: Enter makes a line break and
        -- Esc closes the menu without leaving Insert mode. Use <C-y> to
        -- explicitly accept a completion.
        ["<CR>"] = { "hide", "fallback" },
        ["<Esc>"] = { "hide", "fallback" },
      },
    },
  },
}
