--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('mini.basics').setup {
  options = {
    -- Basic options ('number', 'ignorecase', and many more)
    basic = true,
    -- Extra UI features ('winblend', 'cmdheight=0', ...)
    extra_ui = true,
    win_borders = 'single',
  },
  mappings = {
    basic = true,
    windows = true,
    move_with_alt = true,
  },
  autocommands = {
    basic = true,
  },
}

vim.o.breakindent = true -- Indent wrapped lines to match line start
vim.o.colorcolumn = '+1' -- Draw colored column one step to the right of desired maximum width
vim.o.linebreak = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
vim.o.pumblend = 10 -- Make builtin completion menus slightly transparent
vim.o.pumheight = 10 -- Make popup menu smaller
vim.o.ruler = false -- Don't show cursor position
vim.o.shortmess = 'aoOWFcS' -- Disable certain messages from |ins-completion-menu|
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '   ', trail = '·', nbsp = '␣', extends = '…', precedes = '…' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.laststatus = 3
vim.o.cursorlineopt = 'screenline,number' -- Show cursor line only screen line when wrapped
