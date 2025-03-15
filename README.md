# Opinionated.nvim

Opinionated.nvim is a Neovim plugin that provides a set of sensible **opinionated** default configurations for Neovim. It includes options for various settings, auto commands, and key mappings to enhance your Neovim experience.

## Features

- Line numbers
- Preview substitution
- Search options with smart case and ignore case
- Split options for new windows
- Convert tabs to spaces on save
- Persistent undo
- Virtual visualization in block mode
- Custom update times and timeouts
- Word wrapping at words
- Mouse mode enabled
- Highlight on yank
- Resize splits on window resize
- Intuitive key mappings for navigation and editing

## Installation

Using [lazy](https://github.com/folke/lazy.nvim):

```lua
return {
  "irohn/opinionated.nvim",
  opts = {},
}
```

## Usage
Opinionated.nvim is designed to work out of the box with sensible defaults. If you are not using lazy, you can require it:

```lua
require('opinionated').setup()
```

### Configuration

You can override the default options, auto commands, and key mappings by passing a configuration table to the `setup` function, here are the defaults (no need to copy this unless you want to change anything:

```lua
return {
  "irohn/opinionated.nvim",
  opts = {
    options = {
      -- line numbers
      number = true,
  
      -- preview substitution
      inccommand = "split",
  
      -- search options
      smartcase = true,
      ignorecase = true,
  
      -- split options
      splitbelow = true,
      splitright = true,
  
      -- change tabs into spaces on save
      expandtab = true,
  
      -- persistent undo
      undofile = true,
  
      -- allow virtual visualization in block mode
      virtualedit = "block",
  
      -- update times and timeouts
      updatetime = 250,
      timeoutlen = 500,
  
      -- wrap long lines at words
      linebreak = true,
  
      -- enable mouse mode
      mouse = "a",
    },
  
    autocmds = {
      highlight_on_yank = {
        enabled = true,
        events = "TextYankPost",
        callback = function()
          vim.highlight.on_yank()
        end,
      },
  
      resize_splits = {
        enabled = true,
        events = "VimResized",
        callback = function()
          local current_tab = vim.fn.tabpagenr()
          vim.cmd("tabdo wincmd =")
          vim.cmd("tabnext " .. current_tab)
        end,
      },
    },
  
    keymaps = {
      ["<esc>"] = { mode = "n", action = "<cmd>nohlsearch<cr><esc>", desc = "remove search highlight when pressing esc" },
      ["j"] = { mode = "n", action = "gj", desc = "move down intuitivley when word wrapping" },
      ["k"] = { mode = "n", action = "gk", desc = "move up intuitivley when word wrapping" },
      [">"] = { mode = "v", action = ">gv", desc = "stay in visual mode on indent" },
      ["<"] = { mode = "v", action = "<gv", desc = "stay in visual mode on dedent" },
      ["<c-u>"] = { mode = "n", action = "<c-u>zz", desc = "center screen when scrolling half page up" },
      ["<c-d>"] = { mode = "n", action = "<c-d>zz", desc = "center screen when scrolling half page down" },
      ["n"] = { mode = "n", action = "nzzzv", desc = "center screen on next match" },
      ["N"] = { mode = "n", action = "Nzzzv", desc = "center screen on previous match" },
    },
  },
}
```
