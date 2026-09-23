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
    init = function()
      local function build_typst(source)
        source = vim.fn.fnamemodify(source, ":p")
        local source_dir = vim.fs.dirname(source)
        local output_dir = vim.fs.joinpath(source_dir, "typstbuild")
        local output = vim.fs.joinpath(output_dir, vim.fn.fnamemodify(source, ":t:r") .. ".pdf")

        if vim.fn.executable("typst") == 0 then
          vim.notify("Typst build failed: `typst` is not on Neovim's PATH", vim.log.levels.ERROR)
          return
        end

        vim.fn.mkdir(output_dir, "p")
        vim.system({ "typst", "compile", source, output }, { cwd = source_dir }, function(result)
          if result.code ~= 0 then
            vim.schedule(function()
              vim.notify("Typst build failed:\n" .. result.stderr, vim.log.levels.ERROR)
            end)
          end
        end)
      end

      local group = vim.api.nvim_create_augroup("typst-build", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePost", {
        group = group,
        pattern = "*.typ",
        callback = function(event)
          build_typst(event.match)
        end,
      })

      vim.api.nvim_create_user_command("TypstBuild", function()
        build_typst(vim.api.nvim_buf_get_name(0))
      end, { desc = "Build the current Typst file as a PDF" })
    end,
    keys = {
      { "<leader>t", group = "Typst" },
      { "<leader>tp", "<cmd>TypstBuild<cr><cmd>TypstPreviewToggle<cr>", desc = "Typst Preview" },
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
