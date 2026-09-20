-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<C-k>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<C-j>", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
