local defaults = {
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
    ["<esc><esc>"] = { mode = "t", action = "<C-\\><C-n>", desc = "exit terminal mode" },
  },
}

local M = {}

M.setup = function(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts or {})

  for option, value in pairs(opts.options) do
    vim.opt[option] = value
  end

  local augroup = function(name)
    return vim.api.nvim_create_augroup("opinionated_" .. name, { clear = true })
  end
  for autocmd, value in pairs(opts.autocmds) do
    if value.enabled then
      vim.api.nvim_create_autocmd(value.events, {
        group = augroup(autocmd),
        callback = value.callback
      })
    end
  end

  for keymap, options in pairs(opts.keymaps) do
    vim.keymap.set(options.mode, keymap, options.action, { desc = options.desc })
  end
end

return M

-- vim: ts=2 sts=2 sw=2 et
