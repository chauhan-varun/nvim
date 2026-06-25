-- =============================================================================
-- Core Keymaps
-- lua/core/keymaps.lua
--
-- Base keymaps that are independent of any plugin.
-- Plugin-specific keymaps live inside each plugin's own module.
-- =============================================================================

local map = vim.keymap.set

-- ---------------------------------------------------------------------------
-- General
-- ---------------------------------------------------------------------------

-- Clear search highlight with <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Open quickfix list with all diagnostics for the current buffer
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- ---------------------------------------------------------------------------
-- Insert-mode escapes
-- ---------------------------------------------------------------------------
-- Quickly leave insert mode without reaching for Esc
map('i', 'jk', '<Esc>', { desc = 'Escape insert mode' })
map('i', 'jj', '<Esc>', { desc = 'Escape insert mode' })

-- ---------------------------------------------------------------------------
-- Terminal
-- ---------------------------------------------------------------------------
-- <Esc><Esc> exits terminal mode (the built-in <C-\><C-n> is hard to discover)
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- ---------------------------------------------------------------------------
-- Window navigation
-- ---------------------------------------------------------------------------
-- Use Ctrl+hjkl to move between splits (mirrors tmux pane navigation)
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
