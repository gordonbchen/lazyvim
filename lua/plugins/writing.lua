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
    name = "typst-zathura",
    dir = vim.fn.stdpath("config"),
    ft = "typst",
    init = function()
      local namespaces = {}
      local previews = {}
      local builds = {}
      local errors = {}

      local function source_file()
        local source = vim.api.nvim_buf_get_name(0)
        if source == "" then
          vim.notify("Save the Typst file before building it", vim.log.levels.WARN)
          return nil
        end
        return vim.fn.fnamemodify(source, ":p")
      end

      local function build_typst(source)
        source = vim.fn.fnamemodify(source, ":p")
        local source_dir = vim.fs.dirname(source)
        local output_dir = vim.fs.joinpath(source_dir, "typstbuild")
        local output = vim.fs.joinpath(output_dir, vim.fn.fnamemodify(source, ":t:r") .. ".pdf")

        if vim.fn.executable("typst") == 0 then
          vim.notify("Typst build failed: `typst` is not on Neovim's PATH", vim.log.levels.ERROR)
          return
        end

        builds[source] = (builds[source] or 0) + 1
        local build = builds[source]
        vim.fn.mkdir(output_dir, "p")
        vim.system({ "typst", "compile", "--diagnostic-format", "short", source, output }, { cwd = source_dir }, function(result)
          vim.schedule(function()
            if build ~= builds[source] then
              return
            end

            local namespace = namespaces[source]
            if not namespace then
              namespace = vim.api.nvim_create_namespace("typst-build:" .. source)
              namespaces[source] = namespace
            end
            vim.diagnostic.reset(namespace)
            local items = {}
            local diagnostics = {}
            for line in (result.stderr or ""):gmatch("[^\r\n]+") do
              local file, row, col, severity, message = line:match("^(.-):(%d+):(%d+): ([^:]+): (.+)$")
              if file and (severity == "error" or severity == "warning") then
                local filename = vim.fs.normalize(vim.fs.joinpath(source_dir, file))
                local bufnr = vim.fn.bufadd(filename)
                local level = severity == "error" and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN
                diagnostics[bufnr] = diagnostics[bufnr] or {}
                table.insert(diagnostics[bufnr], {
                  lnum = tonumber(row) - 1,
                  col = tonumber(col) - 1,
                  message = message,
                  severity = level,
                  source = "typst",
                })
                table.insert(items, {
                  filename = filename,
                  lnum = tonumber(row),
                  col = tonumber(col),
                  text = message,
                  type = severity == "error" and "E" or "W",
                })
              end
            end
            for bufnr, entries in pairs(diagnostics) do
              vim.diagnostic.set(namespace, bufnr, entries)
            end
            errors[source] = items
            local title = "Typst: " .. vim.fn.fnamemodify(source, ":t")
            local previous_title = vim.fn.getqflist({ title = 1 }).title
            vim.fn.setqflist({}, "r", { title = title, items = items })

            if result.code ~= 0 then
              if #items > 0 then
                vim.cmd.copen()
              else
                vim.notify("Typst build failed:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
              end
              return
            end

            if previous_title == title and vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
              vim.cmd.cclose()
            end
            if previews[source] == true then
              if vim.fn.executable("zathura") == 0 then
                vim.notify("Zathura is not on Neovim's PATH", vim.log.levels.ERROR)
                previews[source] = nil
                return
              end
              local job
              job = vim.fn.jobstart({ "zathura", output }, {
                on_exit = function()
                  if previews[source] == job then
                    previews[source] = nil
                  end
                end,
              })
              if job > 0 then
                previews[source] = job
              else
                previews[source] = nil
                vim.notify("Could not start Zathura", vim.log.levels.ERROR)
              end
            end
          end)
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
        local source = source_file()
        if source then
          build_typst(source)
        end
      end, { desc = "Build the current Typst file as a PDF" })
      vim.api.nvim_create_user_command("TypstPreview", function()
        local source = source_file()
        if source then
          if not previews[source] then
            previews[source] = true
          end
          build_typst(source)
        end
      end, { desc = "Build and preview the current Typst file in Zathura" })
      vim.api.nvim_create_user_command("TypstPreviewStop", function()
        local source = source_file()
        if source and previews[source] then
          if type(previews[source]) == "number" then
            vim.fn.jobstop(previews[source])
          end
          previews[source] = nil
        end
      end, { desc = "Stop the current Typst preview" })
      vim.api.nvim_create_user_command("TypstErrors", function()
        local source = source_file()
        if source then
          vim.fn.setqflist({}, "r", { title = "Typst: " .. vim.fn.fnamemodify(source, ":t"), items = errors[source] or {} })
          vim.cmd.copen()
        end
      end, { desc = "Show Typst errors" })
    end,
    keys = {
      { "<leader>t", group = "Typst" },
      { "<leader>tp", "<cmd>TypstPreview<cr>", desc = "Typst Preview (Zathura)" },
      { "<leader>ts", "<cmd>TypstPreviewStop<cr>", desc = "Typst Preview Stop" },
      { "<leader>te", "<cmd>TypstErrors<cr>", desc = "Typst Errors" },
      { "<leader>tb", "<cmd>TypstBuild<cr>", desc = "Typst Build" },
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
