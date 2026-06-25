# Varun's nvim config

A custom, fully modular Neovim configuration built from scratch.

## Structure

```
~/.config/nvim/
├── init.lua                    ← entry point (4 lines)
└── lua/
    ├── core/
    │   ├── options.lua         ← editor settings
    │   ├── keymaps.lua         ← base keymaps
    │   └── autocmds.lua        ← autocommands
    └── plugins/
        ├── init.lua            ← lazy.nvim bootstrap
        ├── ai.lua              ← Supermaven AI autocomplete
        ├── completion.lua      ← blink.cmp, LuaSnip
        ├── editing.lua         ← multi-cursor, auto-save, autopairs
        ├── formatting.lua      ← conform, nvim-lint
        ├── git.lua             ← gitsigns, lazygit
        ├── lsp.lua             ← LSP, Mason, diagnostics
        ├── misc.lua            ← which-key, leetcode
        ├── navigation.lua      ← flash, yazi
        ├── telescope.lua       ← fuzzy finder
        ├── treesitter.lua      ← syntax + folding
        └── ui.lua              ← colorscheme, statusline, bufferline
```

## Requirements

- Neovim ≥ 0.10 (latest stable recommended)
- `git`, `make`, `unzip`, `gcc`
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) — used by Telescope live grep
- A [Nerd Font](https://www.nerdfonts.com/) set in your terminal
- `npm` — for TypeScript/JavaScript LSP (`vtsls`)
- `yazi` — for the file manager integration

## Installation

```sh
# Back up existing config first
mv ~/.config/nvim ~/.config/nvim.bak

# Clone
git clone https://github.com/chauhan-varun/nvim.git ~/.config/nvim

# Start Neovim — lazy.nvim will install everything automatically
nvim
```

Run `:Lazy` to check plugin status. Run `:Mason` to check LSP/tool status.

---

## Plugins

### 🎨 UI & Aesthetics (`plugins/ui.lua`)

| Plugin | Purpose |
|---|---|
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Colorscheme (transparent night variant) |
| [noice.nvim](https://github.com/folke/noice.nvim) | Replaces cmdline, messages, and LSP progress with floating UI |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | VS Code-style buffer tabs at the top |
| [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim) | Animated cursor movement |
| [mini.nvim](https://github.com/echasnovski/mini.nvim) | Text objects (ai), surround, **pairs** (auto-close brackets), statusline |
| [todo-comments.nvim](https://github.com/folke/todo-comments.nvim) | Highlights TODO / FIXME / NOTE in comments |

### ⚡ Snacks.nvim (`plugins/snacks.lua`)

| Module | Purpose |
|---|---|
| `snacks.lazygit` | Full LazyGit TUI (replaces kdheepak/lazygit.nvim) |
| `snacks.indent` | Animated indent guides with scope highlight (replaces indent-blankline) |
| `snacks.notifier` | Notification popups (replaces rcarriga/nvim-notify) |
| `snacks.scroll` | Smooth scrolling for `<C-d>`, `<C-u>`, `gg`, `G`, etc. |
| `snacks.words` | Highlight all references to word under cursor + `[[`/`]]` navigation |
| `snacks.rename` | File rename that also updates LSP import paths |
| `snacks.bigfile` | Auto-disables heavy features (treesitter, LSP) on very large files |
| `snacks.quickfile` | Faster file rendering on startup |

### 🔍 Fuzzy Finder (`plugins/telescope.lua`)

| Plugin | Purpose |
|---|---|
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finder — faster than telescope, uses native fzf binary |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | File type icons |

### 🧠 LSP (`plugins/lsp.lua`)

| Plugin | Purpose |
|---|---|
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Language server configurations |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP/tool installer UI |
| [mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim) | Bridge between Mason and lspconfig |
| [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Auto-installs tools on startup |
| [lazydev.nvim](https://github.com/folke/lazydev.nvim) | Neovim API completions for Lua files |

**Installed servers:** `lua_ls`, `clangd`, `vtsls`, `emmet_ls`

**Installed tools:** `stylua`, `prettierd`, `eslint_d`, `emmet-ls`, `lua-language-server`

### ✅ Completion (`plugins/completion.lua`)

| Plugin | Purpose |
|---|---|
| [blink.cmp](https://github.com/saghen/blink.cmp) | Fast completion engine with Rust fuzzy matcher |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) | Pre-built snippet library |

### 🖊️ Formatting & Linting (`plugins/formatting.lua`)

| Plugin | Purpose |
|---|---|
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Format on save + `<leader>cf` on demand |
| [nvim-lint](https://github.com/mfussenegger/nvim-lint) | Async linting on save / insert leave |

**Formatters:** `stylua` (Lua), `prettierd` (JS/TS/CSS/HTML/JSON)  
**Linters:** `eslint_d` (JS/TS), `markdownlint` (Markdown)

### 🌳 Treesitter (`plugins/treesitter.lua`)

| Plugin | Purpose |
|---|---|
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting, indentation, folding |
| [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | Pins current function/class at top of window while scrolling |

**Installed parsers:** bash, c, cpp, html, css, javascript, typescript, tsx, lua, json, markdown, vim, vimdoc

### 🐙 Git (`plugins/git.lua`)

| Plugin | Purpose |
|---|---|
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git gutter signs + hunk actions |
| `snacks.lazygit` | Full LazyGit TUI (via snacks.nvim) |

### 🧭 Navigation (`plugins/navigation.lua`)

| Plugin | Purpose |
|---|---|
| [flash.nvim](https://github.com/folke/flash.nvim) | Instant jump anywhere with 1-2 char labels |
| [yazi.nvim](https://github.com/mikavilpas/yazi.nvim) | Yazi file manager embedded in Neovim |

### ✏️ Editing (`plugins/editing.lua`)

| Plugin | Purpose |
|---|---|
| [vim-sleuth](https://github.com/tpope/vim-sleuth) | Auto-detect indentation per file |
| [vim-visual-multi](https://github.com/mg979/vim-visual-multi) | Multi-cursor (like VS Code Ctrl+D) |
| [auto-save.nvim](https://github.com/okuuva/auto-save.nvim) | Silent auto-save on InsertLeave / TextChanged |
| [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag) | Auto-close and rename HTML/JSX tags |
| `mini.pairs` (via `mini.nvim`) | Auto-close brackets, quotes, parens |

### 🤖 AI (`plugins/ai.lua`)

| Plugin | Purpose |
|---|---|
| [supermaven-nvim](https://github.com/supermaven-inc/supermaven-nvim) | Ultra-fast, lightweight AI code completion |

### 🗂️ Misc (`plugins/misc.lua`)

| Plugin | Purpose |
|---|---|
| [which-key.nvim](https://github.com/folke/which-key.nvim) | Shows available keymaps as you type |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | Beautiful diagnostics, symbols, and LSP references panel |
| [leetcode.nvim](https://github.com/kawre/leetcode.nvim) | Solve LeetCode problems in Neovim |

---

## Keymaps

> **Leader key = `<Space>`**  
> which-key will show available completions after pressing `<leader>`.

### General

| Key | Action |
|---|---|
| `<Esc>` | Clear search highlight |
| `jk` / `jj` | Exit insert mode |
| `<leader>q` | Open diagnostic quickfix list |

### Window Navigation

| Key | Action |
|---|---|
| `<C-h>` | Focus left window |
| `<C-l>` | Focus right window |
| `<C-j>` | Focus lower window |
| `<C-k>` | Focus upper window |

### Buffers (bufferline)

| Key | Action |
|---|---|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `<leader>1`–`9` | Jump to buffer by index |
| `<leader>bb` | Pick buffer (visual picker) |
| `<leader>bp` | Pin / unpin buffer |
| `<leader>bc` | Pick a buffer to close |

### Telescope (Find)

| Key | Action |
|---|---|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search file contents) |
| `<leader>fw` | Grep word under cursor |
| `<leader>fb` | Find open buffers (also `<leader><leader>`) |
| `<leader>fh` | Search help tags |
| `<leader>fk` | Search keymaps |
| `<leader>fd` | Search diagnostics |
| `<leader>fr` | Resume last Telescope search |
| `<leader>f.` | Recent files |
| `<leader>fs` | Select Telescope picker |
| `<leader>/` | Fuzzy search in current buffer |
| `<leader>s/` | Live grep in open files only |
| `<leader>sn` | Search Neovim config files |

### Trouble (Diagnostics Panel)

| Key | Action |
|---|---|
| `<leader>xx` | All project diagnostics |
| `<leader>xX` | Current buffer diagnostics only |
| `<leader>cs` | Document symbols sidebar |
| `<leader>cl` | LSP references + definitions panel |
| `<leader>xQ` | Quickfix list |
| `<leader>xL` | Location list |

### LSP

| Key | Action |
|---|---|
| `grn` | Rename symbol |
| `gra` | Code action |
| `grr` | Go to references |
| `grd` | Go to definition |
| `grD` | Go to declaration |
| `gri` | Go to implementation |
| `grt` | Go to type definition |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `<leader>th` | Toggle inlay hints |

> **Tip:** `[C` jumps up to the surrounding function/class shown by treesitter-context.

### Formatting & Linting

| Key | Action |
|---|---|
| `<leader>cf` | Format current buffer / selection |

### Git (gitsigns)

| Key | Action | Mode |
|---|---|---|
| `]c` | Next hunk | n |
| `[c` | Previous hunk | n |
| `<leader>hs` | Stage hunk | n / v |
| `<leader>hr` | Reset hunk | n / v |
| `<leader>hS` | Stage entire buffer | n |
| `<leader>hR` | Reset entire buffer | n |
| `<leader>hp` | Preview hunk | n |
| `<leader>hb` | Blame current line | n |
| `<leader>hd` | Diff against index | n |
| `<leader>hD` | Diff against last commit | n |
| `<leader>tb` | Toggle inline blame | n |
| `<leader>tD` | Toggle show deleted inline | n |
| `<leader>gg` | Open LazyGit |
| `<leader>gL` | LazyGit log view |
| `<leader>gB` | Open current file/repo in browser | n |

### Navigation

| Key | Action |
|---|---|
| `s` | Flash jump (n / v / o) |
| `S` | Flash Treesitter jump (n / v / o) |
| `r` | Remote flash (operator-pending) |
| `R` | Treesitter search (o / v) |
| `<C-s>` | Toggle Flash in command mode |
| `<leader>-` | Open Yazi at current file |
| `<leader>cw` | Open Yazi at cwd |
| `<leader>ut` | Resume last Yazi session |

### Completion (blink.cmp)

| Key | Action |
|---|---|
| `<CR>` | Accept completion |
| `<C-space>` | Open completion menu / docs |
| `<C-e>` | Close completion menu |
| `<C-k>` | Toggle signature help |
| `<C-n>` / `<C-p>` | Select next / previous item |
| `<Tab>` / `<S-Tab>` | Navigate snippet expansion points |

### Supermaven

| Key | Action |
|---|---|
| `<C-n>` | Accept full suggestion (insert mode) |
| `<C-j>` | Accept next word |
| `<C-l>` | Accept next line |
| `<C-e>` | Dismiss/clear suggestion |

### Multi-cursor (vim-visual-multi)

| Key | Action |
|---|---|
| `<C-n>` | Select word under cursor / next match (normal) |
| `\\A` | Select all matches |

### Mini (text objects & surround)

| Key | Action |
|---|---|
| `va)` | Visually select around `)` |
| `yinq` | Yank inside next quote |
| `ci'` | Change inside `'` |
| `saiw)` | Surround add inner word with `)` |
| `sd'` | Surround delete `'` |
| `sr)'` | Surround replace `)` with `'` |

### Snacks Utilities

| Key | Action |
|---|---|
| `]]` | Next reference of word under cursor |
| `[[` | Prev reference of word under cursor |
| `<leader>rf` | Rename file (updates LSP imports) |
| `<leader>nh` | Show notification history |
| `<leader>nd` | Dismiss all notifications |
| `<leader>gL` | LazyGit log |
| `<leader>gB` | Git browse (open in browser) |

### Terminal

| Key | Action |
|---|---|
| `<Esc><Esc>` | Exit terminal mode |
