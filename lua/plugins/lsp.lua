-- =============================================================================
-- LSP Configuration
-- lua/plugins/lsp.lua
--
-- Manages language servers via Mason, configures them with nvim-lspconfig,
-- and wires up LSP keymaps on each attach event.
-- =============================================================================

return {

  -- ---------------------------------------------------------------------------
  -- lazydev: Lua LSP aware of Neovim API, vim.uv, and plugin types
  -- ---------------------------------------------------------------------------
  {
    'folke/lazydev.nvim',
    ft   = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- ---------------------------------------------------------------------------
  -- nvim-lspconfig: the main LSP client configuration
  -- ---------------------------------------------------------------------------
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Mason: installs LSP servers and tools to stdpath
      { 'williamboman/mason.nvim', opts = {} },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      -- blink.cmp provides extra LSP capabilities (snippets, etc.)
      'saghen/blink.cmp',
    },
    config = function()

      -- -----------------------------------------------------------------------
      -- LSP keymaps — attached per-buffer when an LSP client connects
      -- -----------------------------------------------------------------------
      vim.api.nvim_create_autocmd('LspAttach', {
        group    = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local fzf = require 'fzf-lua'

          map('grn', vim.lsp.buf.rename,          '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action,     '[G]oto Code [A]ction', { 'n', 'x' })
          map('grr', fzf.lsp_references,          '[G]oto [R]eferences')
          map('gri', fzf.lsp_implementations,     '[G]oto [I]mplementation')
          map('grd', fzf.lsp_definitions,         '[G]oto [D]efinition')
          map('grD', vim.lsp.buf.declaration,     '[G]oto [D]eclaration')
          map('gO',  fzf.lsp_document_symbols,    'Open Document Symbols')
          map('gW',  fzf.lsp_live_workspace_symbols, 'Open Workspace Symbols')
          map('grt', fzf.lsp_typedefs,            '[G]oto [T]ype Definition')

          -- Compatibility shim for nvim 0.10 vs 0.11 method checking
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- Document highlight: underline all references to the symbol under cursor
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local hl_group = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer   = event.buf,
              group    = hl_group,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer   = event.buf,
              group    = hl_group,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group    = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
              callback = function(ev)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = ev.buf }
              end,
            })
          end

          -- Inlay hints toggle (if server supports them)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- -----------------------------------------------------------------------
      -- Diagnostics display
      -- -----------------------------------------------------------------------
      vim.diagnostic.config {
        severity_sort = true,
        float         = { border = 'rounded', source = 'if_many' },
        underline     = { severity = vim.diagnostic.severity.ERROR },
        signs         = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN]  = '󰀪 ',
            [vim.diagnostic.severity.INFO]  = '󰋽 ',
            [vim.diagnostic.severity.HINT]  = '󰌶 ',
          },
        } or {},
        virtual_text  = {
          source  = 'if_many',
          spacing = 2,
          format  = function(d) return d.message end,
        },
      }

      -- -----------------------------------------------------------------------
      -- Language server definitions
      -- Add / remove servers here. Each entry maps to a Mason package name.
      -- -----------------------------------------------------------------------
      local servers = {
        clangd = {},

        -- Emmet: HTML / CSS / JSX / TSX completions and expansion
        emmet_ls = {
          filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact' },
        },

        -- TypeScript / JavaScript (vtsls: modern alternative to ts_ls)
        vtsls = {
          settings = {
            typescript = {
              tsserver = {
                maxTsServerMemory = 2048,
                useSyntaxServer = 'never',
              },
            },
            javascript = {
              tsserver = {
                maxTsServerMemory = 2048,
                useSyntaxServer = 'never',
              },
            },
            vtsls = {
              experimental = {
                maxMatchedFiles = 500,
              },
            },
          },
        },

        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
            },
          },
        },
      }

      -- -----------------------------------------------------------------------
      -- Mason installation
      -- -----------------------------------------------------------------------
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',            -- Lua formatter
        'emmet-ls',          -- Emmet for HTML / CSS / JSX / TSX
        'clangd',            -- C/C++ LSP
        'eslint_d',          -- JS/TS linter (fast daemon)
        'prettierd',         -- JS/TS/HTML/CSS formatter (fast daemon)
        'vtsls',             -- TypeScript/JavaScript LSP
        'lua-language-server',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- -----------------------------------------------------------------------
      -- Mason-lspconfig handler: set up each installed server
      -- -----------------------------------------------------------------------
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require('mason-lspconfig').setup {
        ensure_installed    = {},  -- Mason-tool-installer handles installs
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
