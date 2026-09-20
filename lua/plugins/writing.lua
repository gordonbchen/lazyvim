return {
  {
    "folke/noice.nvim",
    enabled = false,
  },
  {
    "folke/which-key.nvim",
    opts = {
      delay = 0,
      spec = {
        { "<leader>t", group = "Typst" },
        { "<leader>v", group = "VimTeX" },
      },
    },
  },
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = { out_dir = "latexbuild" }
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_syntax_conceal_disable = 1
      vim.g.vimtex_mappings_enabled = 0
    end,
    keys = {
      { "<leader>vv", "<cmd>VimtexCompile<cr>", desc = "VimTeX Compile" },
      { "<leader>vk", "<cmd>VimtexStop<cr>", desc = "VimTeX Stop" },
      { "<leader>vl", "<cmd>VimtexView<cr>", desc = "VimTeX View PDF" },
      { "<leader>ve", "<cmd>VimtexErrors<cr>", desc = "VimTeX Errors" },
    },
  },
  {
    "chomosuke/typst-preview.nvim",
    version = "1.*",
    ft = "typst",
    opts = {},
    keys = {
      { "<leader>t", group = "Typst" },
      { "<leader>tp", "<cmd>TypstPreviewToggle<cr>", desc = "Typst Preview" },
      { "<leader>ts", "<cmd>TypstPreviewStop<cr>", desc = "Typst Preview Stop" },
      { "<leader>tc", "<cmd>TypstPreviewSyncCursor<cr>", desc = "Typst Preview Sync Cursor" },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff Working Tree" },
      { "<leader>gD", "<cmd>DiffviewOpen HEAD~1<cr>", desc = "Diff Last Commit" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Git File History" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Git Repository History" },
      { "<leader>gx", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
      { "<leader>gt", "<cmd>DiffviewToggleFiles<cr>", desc = "Toggle Diffview Files" },
    },
    opts = {
      enhanced_diff_hl = true,
      file_panel = { win_config = { width = 30 } },
    },
  },
}
