return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options.theme = {
        normal = {
          a = { fg = "#ff9000", bg = "#1f2335", gui = "bold" },
          b = { fg = "#c0c0c0", bg = "#1f2335" },
          c = { fg = "#c0c0c0", bg = "#1f2335" },
        },
        insert = {
          a = { fg = "#00a0ff", bg = "#1f2335", gui = "bold" },
          b = { fg = "#c0c0c0", bg = "#1f2335" },
          c = { fg = "#c0c0c0", bg = "#1f2335" },
        },
        visual = {
          a = { fg = "#80d0ff", bg = "#1f2335", gui = "bold" },
          b = { fg = "#c0c0c0", bg = "#1f2335" },
          c = { fg = "#c0c0c0", bg = "#1f2335" },
        },
        replace = {
          a = { fg = "#e04040", bg = "#1f2335", gui = "bold" },
          b = { fg = "#c0c0c0", bg = "#1f2335" },
          c = { fg = "#c0c0c0", bg = "#1f2335" },
        },
        inactive = {
          a = { fg = "#808080", bg = "#151530" },
          b = { fg = "#808080", bg = "#151530" },
          c = { fg = "#808080", bg = "#151530" },
        },
      }

      -- Keep the branch legible on min's dark statusline surface.
      opts.sections.lualine_b = {
        { "branch", color = { fg = "#c0c0c0", bg = "#1f2335", gui = "bold" } },
      }

      -- Keep the precise cursor position, but drop the percentage and clock.
      opts.sections.lualine_y = {
        { "location", color = { fg = "#c0c0c0" }, padding = { left = 0, right = 1 } },
      }
      opts.sections.lualine_z = {}
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      highlights = {
        buffer = { fg = "#c0c0c0", bg = "#151530" },
        buffer_visible = { fg = "#c0c0c0", bg = "#151530" },
        buffer_selected = { fg = "#ff9000", bg = "#1f2335", bold = true },
        modified = { fg = "#ff9000", bg = "#151530" },
        modified_visible = { fg = "#ff9000", bg = "#151530" },
        modified_selected = { fg = "#ff9000", bg = "#1f2335", bold = true },
      },
    },
  },
}
