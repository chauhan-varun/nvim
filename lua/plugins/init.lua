-- =============================================================================
-- Plugin Manager Bootstrap + Plugin List
-- lua/plugins/init.lua
--
-- Bootstraps lazy.nvim on first run, then loads all plugin modules.
-- Each module under lua/plugins/*.lua returns a table of lazy plugin specs.
-- =============================================================================

-- ---------------------------------------------------------------------------
-- Bootstrap lazy.nvim (clone if not present)
-- ---------------------------------------------------------------------------
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  local out  = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', repo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- ---------------------------------------------------------------------------
-- Plugin setup
-- Run :Lazy to view status, :Lazy update to update all plugins.
-- ---------------------------------------------------------------------------
require('lazy').setup({
  { import = 'plugins.snacks'     }, -- Utility collection (lazygit, indent, notifier, scroll, words, rename)
  { import = 'plugins.ui'         }, -- Colorscheme, bufferline, statusline, noice…
  { import = 'plugins.telescope'  }, -- Fuzzy finder (fzf-lua)
  { import = 'plugins.lsp'        }, -- Language servers, Mason, diagnostics
  { import = 'plugins.completion' }, -- blink.cmp + LuaSnip
  { import = 'plugins.formatting' }, -- conform.nvim (format) + nvim-lint (lint)
  { import = 'plugins.treesitter' }, -- Syntax, indentation, folding
  { import = 'plugins.git'        }, -- Gitsigns + LazyGit
  { import = 'plugins.navigation' }, -- Flash, Yazi
  { import = 'plugins.editing'    }, -- Multi-cursor, auto-save, autopairs, autotag
  { import = 'plugins.ai'         }, -- Copilot + CopilotChat
  { import = 'plugins.misc'       }, -- which-key, LeetCode
}, {
  ui = {
    -- Use Nerd Font icons when available, otherwise fall back to Unicode emoji
    icons = vim.g.have_nerd_font and {} or {
      cmd     = '⌘', config  = '🛠',  event   = '📅',
      ft      = '📂', init    = '⚙',  keys    = '🗝',
      plugin  = '🔌', runtime = '💻', require = '🌙',
      source  = '📄', start   = '🚀', task    = '📌',
      lazy    = '💤 ',
    },
  },
})
