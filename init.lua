-- =============================================================================
-- Neovim Configuration Entry Point
-- ~/.config/nvim/init.lua
--
-- Structure:
--   lua/core/options.lua    — vim options and global settings
--   lua/core/keymaps.lua    — base keymaps (non-plugin)
--   lua/core/autocmds.lua   — base autocommands
--   lua/plugins/init.lua    — lazy.nvim bootstrap + all plugin modules
-- =============================================================================

-- NOTE: Leader key must be set before lazy.nvim loads (options.lua handles this)
require 'core.options'
require 'core.keymaps'
require 'core.autocmds'
require 'plugins'

-- vim: ts=2 sts=2 sw=2 et
