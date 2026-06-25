-- =============================================================================
-- Treesitter: syntax highlighting, indentation, and folding
-- lua/plugins/treesitter.lua
-- =============================================================================

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'master',
    build  = ':TSUpdate',
    opts   = {
      -- Parsers to always keep installed
      ensure_installed = {
        'bash', 'c', 'cpp', 'diff', 'html', 'css',
        'javascript', 'json', 'lua', 'luadoc',
        'markdown', 'markdown_inline', 'query',
        'solidity', 'tsx', 'typescript', 'vim', 'vimdoc',
      },
      -- Auto-install parsers for any filetype opened (if not already installed)
      auto_install = true,
      highlight    = {
        enable = true,
        -- Ruby still needs vim's regex engine for indent rules
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },

  -- ---------------------------------------------------------------------------
  -- Treesitter Context: pins the current function/class/block name at the
  -- top of the window as you scroll inside it — you always know where you are
  -- ---------------------------------------------------------------------------
  {
    'nvim-treesitter/nvim-treesitter-context',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    opts = {
      max_lines      = 3,      -- max lines of context to show
      trim_scope     = 'outer', -- drop outermost context if over max_lines
      mode           = 'cursor', -- 'cursor' = show context for cursor position
      separator      = nil,    -- nil = no separator line; set '─' for a divider
    },
    keys = {
      -- Jump up into the context (useful in deeply nested code)
      { '[C', function() require('treesitter-context').go_to_context(vim.v.count1) end,
        desc = 'Jump to context (upward)', silent = true },
    },
  },
}
