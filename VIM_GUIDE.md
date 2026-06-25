# 📖 The Ultimate Vim & Neovim Command Reference

Welcome to your comprehensive Vim reference guide. This document contains a master list of core Vim motions, commands, operators, and shortcuts.

---

## 🧭 1. Navigation & Motions

Motions can be combined with Operators (like `d` for delete or `y` for copy).

### Character Navigation
* `h` — Move cursor left.
* `j` — Move cursor down.
* `k` — Move cursor up.
* `l` — Move cursor right.

### Word Navigation
* `w` — Jump forward to the start of the next word.
* `W` — Jump forward to the start of the next word (ignoring punctuation).
* `b` — Jump backward to the start of the previous word.
* `B` — Jump backward to the start of the previous word (ignoring punctuation).
* `e` — Jump forward to the end of the current/next word.
* `E` — Jump forward to the end of the current/next word (ignoring punctuation).
* `ge` — Jump backward to the end of the previous word.

### Line Navigation
* `0` — Jump to the absolute beginning of the line.
* `^` — Jump to the first non-blank character of the line.
* `$` — Jump to the end of the line.
* `g_` — Jump to the last non-blank character of the line.
* `f{char}` — Search forward in the current line for `{char}` and jump to it. (e.g. `f(` jumps to the next `(`).
* `F{char}` — Search backward in the current line for `{char}` and jump to it.
* `t{char}` — Search forward and jump *just before* `{char}`.
* `T{char}` — Search backward and jump *just after* `{char}`.
* `;` — Repeat the last `f`/`F`/`t`/`T` search.
* `,` — Repeat the last `f`/`F`/`t`/`T` search in the opposite direction.

### Paragraph & Section Navigation
* `}` — Jump forward to the next empty line (next paragraph).
* `{` — Jump backward to the previous empty line.
* `%` — Jump between matching brackets: `()`, `[]`, or `{}`.
* `[` — Jump to the start of the current function block (when using treesitter).
* `]` — Jump to the end of the current function block.

### Screen & File Navigation
* `H` — Jump to the **H**igh (top) of the screen.
* `M` — Jump to the **M**iddle of the screen.
* `L` — Jump to the **L**ow (bottom) of the screen.
* `gg` — Jump to the very first line of the file.
* `G` — Jump to the very last line of the file.
* `{number}G` — Jump to line number `{number}` (e.g., `55G` jumps to line 55).
* `<C-f>` — Page Down (Forward).
* `<C-b>` — Page Up (Backward).
* `<C-d>` — Half-page Down.
* `<C-u>` — Half-page Up.
* `zz` — Center the screen on the cursor.
* `zt` — Scroll the screen so the cursor is at the top.
* `zb` — Scroll the screen so the cursor is at the bottom.

---

## ✍️ 2. Editing & Insert Mode

### Entering Insert Mode
* `i` — Insert before the cursor.
* `I` — Insert at the first non-blank character of the line.
* `a` — Append after the cursor.
* `A` — Append at the end of the line.
* `o` — Open a new line below the current line.
* `O` — Open a new line above the current line.
* `s` — Delete the character under the cursor and enter Insert mode.
* `S` — Clear the entire current line and enter Insert mode.

### Leaving Insert Mode
* `Escape` or `Ctrl+[` — Return to Normal mode.
* `jk` / `jj` — Custom escape shortcuts configured in your keymaps.

---

## ✂️ 3. Operators & Actions

Operators perform an action on a motion/target text object.
* **Double the operator to apply it to the whole line** (e.g., `dd` deletes the line, `yy` copies the line).

### Core Operators
* `d` — **Delete** (cuts the text and saves it to register).
* `c` — **Change** (deletes the target and enters Insert mode).
* `y` — **Yank** (copies the target to register).
* `p` — **Paste** after the cursor / below the current line.
* `P` — **Paste** before the cursor / above the current line.
* `r{char}` — **Replace** the character under the cursor with `{char}` (remains in Normal mode).
* `R` — Enter **Replace mode** (overwrite text as you type).
* `~` — Toggle case (lowercase ⇄ uppercase) of the character under the cursor.
* `g~{motion}` — Toggle case of the text matching `{motion}`.
* `gu{motion}` — Convert target text to lowercase.
* `gU{motion}` — Convert target text to uppercase.
* `>` — Indent right.
* `<` — Indent left.
* `=` — Auto-format indentation (uses LSP or internal formatter).

### Number Manipulation
* `<C-a>` — **Increment** the number under/after the cursor.
* `<C-x>` — **Decrement** the number under/after the cursor.

---

## 📦 4. Text Objects

Text objects are target scopes that can be combined with Operators (`d`, `c`, `y`, `v`, etc.).
* **Format:** `[Operator] + [i / a] + [Object]`
* `i` = **inner** (selects only the content).
* `a` = **around** (includes surrounding spaces, quotes, or brackets).

### Text Object Reference
* `w` — Word (e.g. `diw` deletes inner word, `caw` changes around word).
* `s` — Sentence.
* `p` — Paragraph.
* `"`, `'`, \`` — Quotes (e.g. `ci"` changes text inside double quotes).
* `(`, `)`, `b` — Parentheses `()` (e.g. `di(` deletes inside parens).
* `[`, `]` — Square brackets `[]`.
* `{`, `}`, `B` — Curly braces `{}`.
* `t` — HTML/XML tags (e.g. `cit` changes text inside `<div>hello</div>`).

---

## 🖥️ 5. Visual Mode (Selection)

Visual mode is used to highlight blocks of code.
* `v` — Start character-wise Visual mode.
* `V` — Start line-wise Visual mode.
* `<C-v>` — Start block-wise (column) Visual mode.
* `gv` — Re-select your last visual selection.
* `o` — Switch cursor focus between the start and end of the selection.

### Column Editing (Multi-Line Edit)
To write text on multiple lines at the same time:
1. Press `<C-v>` to enter Visual Block mode.
2. Select a vertical column of characters.
3. Press `I` (capital `i`) to insert before, or `A` to append after.
4. Type your text.
5. Press `Escape` twice. The text will be cloned onto all selected lines.

---

## 🗃️ 6. Registers (Clipboard History)

Vim has multiple memory slots (registers) to store copied/deleted text.
* To use a register, press `"` followed by the register name before your copy/paste action.
* **Syntax:** `"{register}[Operator]` or `"{register}p`

### Register Types
* `""` — The **unnamed register** (default). Stores the last yank/delete.
* `"0` — The **yank register**. Stores the last copied text (not affected by deletes).
* `"+` / `"*` — The **system clipboard**. Allows copy-pasting to and from external apps.
  * *Example:* `"+y` copies to system clipboard; `"+p` pastes from system clipboard.
* `"a` to `"z` — **Named registers**. Stores text persistently.
  * *Example:* `"ay` yanks text into register `a`. `"ap` pastes text from register `a`.
* `"_` — The **black hole register**. Deleting to `"_` discards the text completely (doesn't overwrite your copy clipboard).
  * *Example:* `"_dd` deletes a line permanently without losing your previously copied text.

---

## 🔁 7. Macros (Automation)

Macros allow you to record a series of keystrokes and play them back.

### Recording & Playback
1. Press `q{register}` to start recording into a register (e.g., `qa` starts recording in `a`).
2. Perform your editing actions.
3. Press `q` to stop recording.
4. Press `@{register}` to replay the macro (e.g. `@a` plays the macro in `a`).
5. Press `@@` to replay the last played macro.
* *Tip:* Type `{number}@{register}` to repeat the macro multiple times (e.g. `10@a` runs it 10 times).

---

## 📁 8. Command Line & Search

Press `:` in Normal mode to open the command line.

### Save & Quit
* `:w` — Save (Write) current file.
* `:q` — Quit current window.
* `:wq` or `:x` — Save and quit.
* `:q!` — Force quit without saving changes.
* `:wa` — Save all open files.
* `:qa` — Close all windows and exit Neovim.

### Search
* `/pattern` — Search forward for `pattern`.
* `?pattern` — Search backward for `pattern`.
* `n` — Jump to next search match.
* `N` — Jump to previous search match.
* `*` — Search forward for the word under the cursor.
* `#` — Search backward for the word under the cursor.

### Replace (Substitution)
* `:%s/old/new/g` — Find `old` and replace it with `new` in the entire file.
* `:%s/old/new/gc` — Replace all occurrences but ask for confirmation (`y`/`n`) for each.
* `:s/old/new/g` — Replace occurrences only on the current line.
* `:{range}s/old/new/g` — Replace in a range of lines (e.g. `:10,20s/old/new/g`).

---

## 📑 9. Windows, Buffers, & Splits

### Creating Splits
* `<C-w>s` or `:sp` — Split window horizontally.
* `<C-w>v` or `:vsp` — Split window vertically.

### Managing Splits
* `<C-w>c` or `:q` — Close the current split.
* `<C-w>o` or `:only` — Close all splits except the active one.
* `<C-w>=` — Resize all splits to be equal size.
* `<C-w>>` / `<C-w><` — Increase / decrease split width.
* `<C-w>+` / `<C-w>-` — Increase / decrease split height.

### Window Navigation
* `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` — Move focus left/down/up/right (configured in your keymaps).

---

## 📂 10. Code Folding

If you have treesitter or marker folding enabled:
* `za` — Toggle fold under the cursor.
* `zc` — Close fold under the cursor.
* `zo` — Open fold under the cursor.
* `zM` — Close all folds in the current file.
* `zR` — Open all folds in the current file.

---

## ⚡ 11. Custom Configurations In Your Setup

Your personal configuration adds several plugins that run alongside standard Vim commands:
* **Fuzzy Finder:** Open with `<leader>ff` (Telescope) or search file content with `<leader>fg`.
* **File Manager:** Press `-` in Normal mode to open Yazi.
* **LSP Rename:** Press `grn` to rename variables project-wide.
* **Autocomplete Selection:** Use `<C-n>`, `<C-j>`, `<C-l>` for Supermaven inline completions.
