local function setup()
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  vim.g.have_nerd_font = true

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
  vim.opt.listchars = { tab = '   ', trail = '·', nbsp = '␣' }
  vim.opt.inccommand = 'split'
  vim.opt.cursorline = true
  vim.opt.scrolloff = 5
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.expandtab = true
  vim.opt.laststatus = 3
end

return { setup = setup }
