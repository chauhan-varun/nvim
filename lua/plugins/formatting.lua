-- =============================================================================
-- Formatting & Linting
-- lua/plugins/formatting.lua
-- =============================================================================

return {

  -- ---------------------------------------------------------------------------
  -- conform.nvim: auto-format on save and on-demand via <leader>cf
  -- ---------------------------------------------------------------------------
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd   = { 'ConformInfo' },
    keys  = {
      {
        '<leader>cf',
        function() require('conform').format { async = true, lsp_format = 'fallback' } end,
        mode = '',
        desc = '[C]ode [F]ormat',
      },
    },
    opts = {
      notify_on_error  = false,
      format_on_save   = function(bufnr)
        -- Disable format-on-save for C/C++ (no universally agreed style)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then return nil end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,
      formatters_by_ft = {
        lua             = { 'stylua' },
        javascript      = { 'prettierd', stop_after_first = true },
        javascriptreact = { 'prettierd', stop_after_first = true },
        typescript      = { 'prettierd' },
        typescriptreact = { 'prettierd' },
        css             = { 'prettierd' },
        html            = { 'prettierd' },
        json            = { 'prettierd' },
      },
    },
  },

  -- ---------------------------------------------------------------------------
  -- nvim-lint: run linters on save / insert leave
  -- ---------------------------------------------------------------------------
  {
    'mfussenegger/nvim-lint',
    event  = { 'BufReadPre', 'BufNewFile' },
    config = function()
      local lint = require 'lint'

      lint.linters_by_ft = {
        markdown        = { 'markdownlint' },
        javascript      = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
        typescript      = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
      }

      -- Run linting on these events (only for modifiable buffers)
      local lint_group = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group    = lint_group,
        callback = function()
          if vim.opt_local.modifiable:get() then
            lint.try_lint()
          end
        end,
      })
    end,
  },
}
