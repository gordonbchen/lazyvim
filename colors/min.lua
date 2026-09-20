-- min.nvim -- a deliberately small, high-contrast dark colourscheme.
-- It keeps the original black / navy / cyan palette while covering modern
-- Neovim, Tree-sitter, LSP, and the UI groups used by LazyVim.

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "min"
vim.o.termguicolors = true

local p = {
  black = "#000000",
  navy = "#151530",
  panel = "#1f2335",
  selection = "#222244",
  gutter = "#606060",
  muted = "#8a8a8a",
  foreground = "#dfdfdf",
  dim = "#c0c0c0",
  cyan = "#80d0ff",
  blue = "#00a0ff",
  orange = "#ff9000",
  red = "#e04040",
  yellow = "#d0d000",
  green = "#00ff00",
  diff_add = "#003d18",
  diff_delete = "#4b1018",
  diff_change = "#101c4d",
  diff_text = "#5c3b00",
}

local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end
local link = function(group, target)
  hi(group, { link = target })
end

-- Editor chrome
hi("Normal", { fg = p.foreground, bg = p.black })
hi("NormalNC", { fg = p.foreground, bg = p.black })
hi("NormalFloat", { fg = p.cyan, bg = p.navy })
hi("FloatBorder", { fg = p.gutter, bg = p.navy })
hi("FloatTitle", { fg = p.orange, bg = p.navy, bold = true })
hi("ColorColumn", { bg = p.panel })
hi("CursorLine", { bg = p.selection })
hi("CursorColumn", { bg = p.selection })
hi("CursorLineNr", { fg = p.foreground, bg = p.selection, bold = true })
-- Keep the gutter unobtrusive; the statuscolumn adds one faint edge divider.
hi("LineNr", { fg = "#c0c0c0", bg = p.panel })
hi("SignColumn", { fg = "#a0a0a0", bg = p.navy })
hi("FoldColumn", { fg = "#a0a0a0", bg = p.navy })
hi("StatusColumn", { fg = "#c0c0c0", bg = p.navy })
hi("Folded", { fg = p.muted, bg = p.navy })
hi("WinSeparator", { fg = p.gutter, bg = p.black })
hi("VertSplit", { fg = p.gutter, bg = p.black })
hi("EndOfBuffer", { fg = p.navy, bg = p.black })
hi("NonText", { fg = p.gutter })
hi("Whitespace", { fg = p.gutter })
hi("SpecialKey", { fg = p.gutter })
hi("MatchParen", { fg = p.black, bg = p.orange, bold = true })
hi("Visual", { bg = p.selection })
hi("VisualNOS", { bg = p.selection })
hi("Search", { fg = p.black, bg = p.yellow })
hi("IncSearch", { fg = p.black, bg = p.orange })
hi("CurSearch", { fg = p.black, bg = p.orange, bold = true })
hi("Substitute", { fg = p.black, bg = p.red })
hi("QuickFixLine", { bg = p.selection, bold = true })
hi("Pmenu", { fg = p.cyan, bg = p.navy })
hi("PmenuSel", { fg = p.foreground, bg = p.selection, bold = true })
hi("PmenuMatch", { fg = p.orange, bg = p.selection, bold = true })
hi("PmenuMatchSel", { fg = p.orange, bg = p.selection, bold = true })
hi("PmenuSbar", { bg = p.panel })
hi("PmenuThumb", { bg = p.gutter })
hi("StatusLine", { fg = p.cyan, bg = p.panel })
hi("StatusLineNC", { fg = p.muted, bg = p.navy })
hi("TabLine", { fg = p.muted, bg = p.navy })
hi("TabLineSel", { fg = p.cyan, bg = p.panel, bold = true })
hi("TabLineFill", { bg = p.black })
hi("Title", { fg = p.orange, bold = true })
hi("Directory", { fg = p.blue })
hi("Question", { fg = p.green })
hi("WarningMsg", { fg = p.yellow })
hi("ErrorMsg", { fg = p.red, bold = true })
hi("MoreMsg", { fg = p.green })
hi("ModeMsg", { fg = p.cyan })

-- Vim syntax (also the fallbacks for languages without a parser)
hi("Comment", { fg = p.dim, italic = true })
hi("Constant", { fg = p.cyan })
hi("String", { fg = p.cyan })
hi("Character", { fg = p.cyan })
hi("Number", { fg = p.cyan })
hi("Boolean", { fg = p.cyan })
hi("Float", { fg = p.cyan })
hi("Identifier", { fg = p.orange })
hi("Function", { fg = p.blue })
hi("Statement", { fg = p.red, italic = true })
hi("Conditional", { fg = p.red, italic = true })
hi("Repeat", { fg = p.red, italic = true })
hi("Label", { fg = p.red, italic = true })
hi("Operator", { fg = p.foreground })
hi("Keyword", { fg = p.red, italic = true })
hi("Exception", { fg = p.red, italic = true })
hi("PreProc", { fg = p.yellow })
hi("Include", { fg = p.yellow })
hi("Define", { fg = p.yellow })
hi("Macro", { fg = p.yellow })
hi("Type", { fg = p.orange })
hi("StorageClass", { fg = p.orange })
hi("Structure", { fg = p.orange })
hi("Typedef", { fg = p.orange })
hi("Special", { fg = p.yellow })
hi("Delimiter", { fg = p.foreground })
hi("Underlined", { fg = p.blue, underline = true })
hi("Todo", { fg = p.black, bg = p.yellow, bold = true })
hi("Error", { fg = p.red, bold = true })
hi("ocamlKeyChar", { fg = p.foreground, italic = false })
hi("typstCodeFunctionArgument", { fg = p.orange, underline = false, undercurl = false })
hi("typstCodeParen", { fg = p.foreground, underline = false, undercurl = false })
hi("typstCodeBrace", { fg = p.foreground, underline = false, undercurl = false })
hi("typstCodeBracket", { fg = p.foreground, underline = false, undercurl = false })

-- Tree-sitter semantic groups
link("@comment", "Comment")
link("@string", "String")
link("@string.escape", "Special")
link("@string.regex", "Special")
link("@character", "Character")
link("@number", "Number")
link("@boolean", "Boolean")
link("@constant", "Constant")
link("@constant.builtin", "Constant")
link("@variable", "Normal")
link("@variable.builtin", "Special")
link("@parameter", "Identifier")
link("@property", "Identifier")
link("@field", "Identifier")
link("@function", "Function")
link("@function.builtin", "Function")
link("@function.call", "Function")
link("@method", "Function")
link("@constructor", "Type")
link("@keyword", "Keyword")
link("@keyword.function", "Keyword")
link("@keyword.return", "Keyword")
link("@conditional", "Conditional")
link("@repeat", "Repeat")
link("@operator", "Operator")
link("@type", "Type")
link("@type.builtin", "Type")
link("@module", "Type")
link("@attribute", "PreProc")
link("@tag", "Type")
link("@tag.attribute", "Identifier")
link("@tag.delimiter", "Delimiter")
link("@punctuation.delimiter", "Delimiter")
link("@punctuation.bracket", "Delimiter")
link("@markup.heading", "Title")
hi("@markup.strong", { bold = true })
hi("@markup.italic", { italic = true })
link("@markup.link", "Underlined")
link("@markup.raw", "String")

-- Diagnostics, LSP, and completion
hi("DiagnosticError", { fg = p.red })
hi("DiagnosticWarn", { fg = p.yellow })
hi("DiagnosticInfo", { fg = p.cyan })
hi("DiagnosticHint", { fg = p.green })
hi("DiagnosticOk", { fg = p.green })
hi("DiagnosticVirtualTextError", { fg = p.red, bg = p.diff_delete })
hi("DiagnosticVirtualTextWarn", { fg = p.yellow, bg = p.diff_text })
hi("DiagnosticVirtualTextInfo", { fg = p.cyan, bg = p.diff_change })
hi("DiagnosticVirtualTextHint", { fg = p.green, bg = p.diff_add })
hi("DiagnosticUnderlineError", { undercurl = true, sp = p.red })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = p.yellow })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = p.cyan })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = p.green })
link("LspReferenceText", "Visual")
link("LspReferenceRead", "Visual")
link("LspReferenceWrite", "Visual")
hi("LspInlayHint", { fg = p.muted, bg = p.navy, italic = true })
link("@lsp.type.class", "Type")
link("@lsp.type.enum", "Type")
link("@lsp.type.interface", "Type")
link("@lsp.type.namespace", "Type")
link("@lsp.type.parameter", "Identifier")
link("@lsp.type.property", "Identifier")
link("@lsp.type.variable", "Normal")

-- Diff: low-intensity line backgrounds, then a warm precise-change overlay.
-- This works for :diffsplit, Snacks git diff, and Gitsigns' word highlights.
hi("DiffAdd", { bg = p.diff_add })
hi("DiffDelete", { fg = p.red, bg = p.diff_delete })
hi("DiffChange", { bg = p.diff_change })
hi("DiffText", { fg = p.foreground, bg = p.diff_text, bold = true })
hi("Added", { fg = p.green })
hi("Removed", { fg = p.red })
hi("Changed", { fg = p.blue })
hi("GitSignsAdd", { fg = p.green })
hi("GitSignsChange", { fg = p.blue })
hi("GitSignsDelete", { fg = p.red })
hi("GitSignsAddLn", { bg = p.diff_add })
hi("GitSignsChangeLn", { bg = p.diff_change })
hi("GitSignsDeleteLn", { bg = p.diff_delete })
hi("GitSignsAddInline", { bg = "#006b28" })
hi("GitSignsChangeInline", { bg = p.diff_text })
hi("GitSignsDeleteInline", { bg = "#751522" })

-- Common LazyVim plugin surfaces
hi("WhichKey", { fg = p.orange })
hi("WhichKeyGroup", { fg = p.cyan })
hi("WhichKeyDesc", { fg = p.foreground })
hi("WhichKeySeparator", { fg = p.gutter })
hi("TelescopeBorder", { fg = p.gutter, bg = p.navy })
hi("TelescopeTitle", { fg = p.orange, bg = p.navy, bold = true })
hi("TelescopeSelection", { bg = p.selection, bold = true })
hi("TelescopeMatching", { fg = p.orange, bold = true })
hi("SnacksPicker", { fg = p.foreground, bg = p.black })
hi("SnacksPickerBorder", { fg = p.gutter, bg = p.black })
hi("SnacksPickerTitle", { fg = p.orange, bold = true })
hi("SnacksPickerMatch", { fg = p.orange, bold = true })
hi("SnacksPickerSelection", { bg = p.selection, bold = true })
hi("BufferLineFill", { bg = p.black })
hi("BufferLineBackground", { fg = p.muted, bg = p.navy })
hi("BufferLineBufferSelected", { fg = p.cyan, bg = p.panel, bold = true })
hi("BufferLineIndicatorSelected", { fg = p.orange, bg = p.panel })
hi("BufferLineModified", { fg = p.orange, bg = p.navy })
hi("BufferLineModifiedSelected", { fg = p.orange, bg = p.panel, bold = true })
hi("NeoTreeNormal", { fg = p.foreground, bg = p.black })
hi("NeoTreeNormalNC", { fg = p.foreground, bg = p.black })
hi("NeoTreeDirectoryName", { fg = p.blue })
hi("NeoTreeGitAdded", { fg = p.green })
hi("NeoTreeGitModified", { fg = p.blue })
hi("NeoTreeGitDeleted", { fg = p.red })
hi("LazyNormal", { fg = p.foreground, bg = p.navy })
hi("LazyButton", { fg = p.cyan, bg = p.panel })
hi("LazyButtonActive", { fg = p.black, bg = p.orange, bold = true })
hi("TroubleNormal", { fg = p.foreground, bg = p.black })
hi("TroubleText", { fg = p.foreground })

vim.g.terminal_color_0 = p.black
vim.g.terminal_color_1 = p.red
vim.g.terminal_color_2 = p.green
vim.g.terminal_color_3 = p.yellow
vim.g.terminal_color_4 = p.blue
vim.g.terminal_color_5 = p.orange
vim.g.terminal_color_6 = p.cyan
vim.g.terminal_color_7 = p.dim
vim.g.terminal_color_8 = p.gutter
vim.g.terminal_color_9 = p.red
vim.g.terminal_color_10 = p.green
vim.g.terminal_color_11 = p.yellow
vim.g.terminal_color_12 = p.blue
vim.g.terminal_color_13 = p.orange
vim.g.terminal_color_14 = p.cyan
vim.g.terminal_color_15 = p.foreground
