-- Check out Kickstart https://github.com/nvim-lua/kickstart.nvim
-- this config has kickstart as starting point

-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath 'data' .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
  vim.cmd 'echo "Installing `mini.nvim`" | redraw'
  local clone_cmd = {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim',
    mini_path,
  }
  vim.fn.system(clone_cmd)
  vim.cmd 'packadd mini.nvim | helptags ALL'
  vim.cmd 'echo "Installed `mini.nvim`" | redraw'
end

-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup { path = { package = path_package } }

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- basic configurations
require 'custom.basics'

now(require('custom.plugins.starter').setup)

now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()
end)

now(require('custom.plugins.statusline').setup)

now(function()
  require('mini.pairs').setup()
end)

now(function()
  require('mini.sessions').setup()
end)

now(function()
  require('mini.icons').setup()
  MiniIcons.mock_nvim_web_devicons()
end)

now(function()
  add { source = 'rose-pine/neovim' }
  add { source = 'rebelot/kanagawa.nvim' }
  add { source = 'folke/tokyonight.nvim' }
  add { source = 'luisiacc/gruvbox-baby' }
  add { source = 'catppuccin/nvim', name = 'catpuccin' }
  add { source = 'cryptomilk/nightcity.nvim' }
  add { source = 'Verf/deepwhite.nvim' }
  add { source = 'zootedb0t/citruszest.nvim' }
  add { source = 'zenbones-theme/zenbones.nvim', depends = {
    'rktjmp/lush.nvim',
  } }

  require('kanagawa').setup {
    colors = {
      theme = {
        all = {
          ui = {
            bg_gutter = 'none',
          },
        },
      },
    },
  }

  -- vim.g.gruvbox_baby_background_color = 'dark'
  vim.g.gruvbox_baby_use_original_palette = false
  vim.opt.background = 'dark'
  vim.g.zenbones = { lightness = 'dim', darkness = 'stark', lighten_noncurrent_window = true }

  vim.cmd.colorscheme 'gruvbox-baby'
end)

now(function()
  add { source = 'nvim-lua/plenary.nvim' }
end)

-- Which key like interface
now(require('custom.plugins.clue').setup)

later(function()
  require('mini.files').setup {
    -- Customization of explorer windows
    windows = {
      -- Maximum number of windows to show side by side
      max_number = 3,
      -- Whether to show preview of file/directory under cursor
      preview = false,
    },
  }

  vim.keymap.set('n', '<leader>f', MiniFiles.open, { desc = 'File Explorer' })
end)

later(function()
  require('mini.diff').setup {
    view = {
      style = 'sign',
    },
  }
end)

later(function()
  require('mini.git').setup()
end)

later(function()
  require('mini.jump').setup()
end)

later(function()
  require('mini.jump2d').setup {}
end)

now(function()
  add 'stevearc/dressing.nvim'
  require('dressing').setup {}
end)

-- Safely execute later
later(function()
  require('mini.ai').setup()
  require('mini.surround').setup()
  require('mini.comment').setup()
  require('mini.surround').setup()
  require('mini.bracketed').setup {}
end)

later(function()
  add { source = 'tpope/vim-sleuth' } -- Detect tabstop and shiftwidth automatically
end)

later(function()
  add {
    source = 'hrsh7th/nvim-cmp',
    depends = {
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
  }
  add {
    source = 'L3MON4D3/LuaSnip',
    depends = {
      'rafamadriz/friendly-snippets',
      'lukas-reineke/cmp-under-comparator',
    },
    hooks = {
      post_checkout = function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end,
    },
  }
  require 'custom.plugins.completion'
end)

later(function()
  add {
    source = 'neovim/nvim-lspconfig',
    depends = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      'folke/neodev.nvim',

      'MysticalDevil/inlay-hints.nvim',
    },
  }
  require 'custom.plugins.lsp'
end)

later(function()
  add {
    source = 'stevearc/conform.nvim',
  }

  local conform = require 'conform'
  conform.setup {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use a sub-list to tell conform to run *until* a formatter
      -- is found.
      javascript = { { 'prettierd', 'prettier', 'biome' } },
      javascriptreact = { { 'prettierd', 'prettier', 'biome' } },
      typescript = { { 'prettierd', 'prettier', 'biome' } },
      typescriptreact = { { 'prettierd', 'prettier', 'biome' } },
      json = { { 'prettierd', 'prettier', 'biome', 'jq' } },
    },
  }
  vim.keymap.set('n', '<leader>lf', function()
    conform.format { lsp_fallback = true }
  end, { desc = 'Format' })
end)

later(function()
  add { source = 'folke/todo-comments.nvim', depends = { 'nvim-lua/plenary.nvim' } }
  require('todo-comments').setup { signs = true }
end)

later(function()
  add {
    source = 'nvim-treesitter/nvim-treesitter',
    -- Use 'master' while monitoring updates in 'main'
    checkout = 'master',
    monitor = 'main',
    -- Perform action after every checkout
    hooks = {
      post_checkout = function()
        vim.cmd 'TSUpdate'
      end,
    },
  }
  add { source = 'windwp/nvim-ts-autotag' }
  require('custom.plugins.treesitter').setup()
end)

later(function()
  add {
    source = 'mfussenegger/nvim-dap',
    depends = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Required dependency for nvim-dap-ui
      'nvim-neotest/nvim-nio',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
  }
  require('custom.plugins.dap').setup()
end)

require 'custom.config.keymaps'
require 'custom.config.python'

-- vim: ts=2 sts=2 sw=2 et
