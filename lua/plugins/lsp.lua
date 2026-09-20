return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Use the already installed system clangd; Mason installs Pyright.
        clangd = { mason = false },
        pyright = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Python is already a LazyVim default; C++ is not.
      vim.list_extend(opts.ensure_installed, { "cpp" })
    end,
  },
}
