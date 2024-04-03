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

now(function()
  require('mini.basics').setup {
    options = {
      basic = true,
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
      relnum_in_visual_mode = false,
    },
  }
end)

now(function()
  require('mini.notify').setup()
  vim.notify = require('mini.notify').make_notify()
end)

now(function()
  require('mini.tabline').setup()
end)

now(function()
  -- Status line --
  local active = function()
    local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 999 }
    local git = MiniStatusline.section_git { trunc_width = 75 }
    local diagnostics = MiniStatusline.section_diagnostics { trunc_width = 75 }
    local filename = MiniStatusline.section_filename { trunc_width = 140 }
    local fileinfo = MiniStatusline.section_fileinfo { trunc_width = 120 }
    local location = MiniStatusline.section_location { trunc_width = 75 }

    return MiniStatusline.combine_groups {
      { hl = mode_hl, strings = { mode } },
      { hl = 'MiniStatuslineDevinfo', strings = { git, diagnostics } },
      '%<%=', -- Mark general truncate point
      { hl = 'MiniStatuslineFilename', strings = { filename } },
      { hl = 'MiniStatuslineFileinfo', strings = {} },
      '%=', -- End left alignment
      { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
      { hl = mode_hl, strings = { location } },
    }
  end

  require('mini.statusline').setup {
    content = {
      active = active,
    },
    set_vim_settings = false,
  }
end)
now(function()
  require('mini.pairs').setup()
end)

now(function()
  -- Add to current session (install if absent)
  add 'nvim-tree/nvim-web-devicons'
  require('nvim-web-devicons').setup()
end)

now(function()
  add { source = 'rose-pine/neovim' }
  add { source = 'rebelot/kanagawa.nvim' }
  add { source = 'folke/tokyonight.nvim' }
  add { source = 'dasupradyumna/midnight.nvim' }
  add { source = 'luisiacc/gruvbox-baby' }

  vim.cmd.colorscheme 'midnight'
end)

now(function()
  add { source = 'nvim-lua/plenary.nvim' }
end)

now(function()
  -- Which key like interface
  local miniclue = require 'mini.clue'
  miniclue.setup {
    triggers = {
      -- Leader triggers
      { mode = 'n', keys = '<Leader>' },
      { mode = 'x', keys = '<Leader>' },

      -- Built-in completion
      { mode = 'i', keys = '<C-x>' },

      -- `g` key
      { mode = 'n', keys = 'g' },
      { mode = 'x', keys = 'g' },

      -- Marks
      { mode = 'n', keys = "'" },
      { mode = 'n', keys = '`' },
      { mode = 'x', keys = "'" },
      { mode = 'x', keys = '`' },

      -- Registers
      { mode = 'n', keys = '"' },
      { mode = 'x', keys = '"' },
      { mode = 'i', keys = '<C-r>' },
      { mode = 'c', keys = '<C-r>' },

      -- Window commands
      { mode = 'n', keys = '<C-w>' },

      -- `z` key
      { mode = 'n', keys = 'z' },
      { mode = 'x', keys = 'z' },
    },

    clues = {
      -- Enhance this by adding descriptions for <Leader> mapping groups
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),
    },
  }
end)

now(function()
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

now(function()
  -- extra stuff
  local extra = require 'mini.extra'
  extra.setup {}

  -- Pick things
  local pick = require 'mini.pick'
  pick.setup {}

  vim.keymap.set('n', '<leader><leader>', pick.builtin.buffers, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>s.', extra.pickers.oldfiles, { desc = '[ ] Find existing buffers' })
  vim.keymap.set('n', '<leader>sr', pick.builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>sh', pick.builtin.help, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', extra.pickers.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', pick.builtin.files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>sw', pick.builtin.grep, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', pick.builtin.grep_live, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', extra.pickers.diagnostic, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sm', extra.pickers.marks, { desc = '[S]earch [M]arks' })
  vim.keymap.set('n', '<leader>/', function()
    extra.pickers.buf_lines { scope = 'current' }
  end, { desc = 'Search in current file' })
  vim.keymap.set('n', '<leader>/', function()
    extra.pickers.buf_lines { scope = 'all' }
  end, { desc = 'Search in open files' })
end)

now(function()
  require('mini.jump2d').setup {}
end)

-- Safely execute later
later(function()
  require('mini.ai').setup()
end)

later(function()
  require('mini.surround').setup()
end)

later(function()
  require('mini.comment').setup()
end)

later(function()
  require('mini.pick').setup()
end)

later(function()
  require('mini.surround').setup()
end)

later(function()
  require('mini.bracketed').setup {}
end)

later(function()
  add { source = 'tpope/vim-sleuth' } -- Detect tabstop and shiftwidth automatically
end)

later(function()
  add { source = 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  }
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

  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true, typescript = true, typescriptreact = true, javascript = true, javascriptreact = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
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

  ---@diagnostic disable-next-line: missing-fields
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    autotag = {
      enable = true,
    },
  }
end)

later(function()
  add { source = 'mfussenegger/nvim-lint' }
  local lint = require 'lint'
  lint.linters_by_ft = {
    markdown = { 'markdownlint' },
  }

  -- To allow other plugins to add linters to require('lint').linters_by_ft,
  -- instead set linters_by_ft like this:
  -- lint.linters_by_ft = lint.linters_by_ft or {}
  -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
  --
  -- However, note that this will enable a set of default linters,
  -- which will cause errors unless these tools are available:
  -- {
  --   clojure = { "clj-kondo" },
  --   dockerfile = { "hadolint" },
  --   inko = { "inko" },
  --   janet = { "janet" },
  --   json = { "jsonlint" },
  --   markdown = { "vale" },
  --   rst = { "vale" },
  --   ruby = { "ruby" },
  --   terraform = { "tflint" },
  --   text = { "vale" }
  -- }
  --
  -- You can disable the default linters by setting their filetypes to nil:
  -- lint.linters_by_ft['clojure'] = nil
  -- lint.linters_by_ft['dockerfile'] = nil
  -- lint.linters_by_ft['inko'] = nil
  -- lint.linters_by_ft['janet'] = nil
  -- lint.linters_by_ft['json'] = nil
  -- lint.linters_by_ft['markdown'] = nil
  -- lint.linters_by_ft['rst'] = nil
  -- lint.linters_by_ft['ruby'] = nil
  -- lint.linters_by_ft['terraform'] = nil
  -- lint.linters_by_ft['text'] = nil

  -- Create autocommand which carries out the actual linting
  -- on the specified events.
  local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = lint_augroup,
    callback = function()
      require('lint').try_lint()
    end,
  })
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
  local dap = require 'dap'
  local dapui = require 'dapui'

  require('mason-nvim-dap').setup {
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_setup = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},

    -- You'll need to check that you have the required things installed
    -- online, please don't ask me how to install them :)
    ensure_installed = {
      -- Update this to ensure that you have the debuggers for the langs you want
      'delve',
    },
  }

  -- Basic debugging keymaps, feel free to change to your liking!
  vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
  vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
  vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
  vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
  vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
  vim.keymap.set('n', '<leader>B', function()
    dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
  end, { desc = 'Debug: Set Breakpoint' })

  -- Dap UI setup
  -- For more information, see |:help nvim-dap-ui|
  dapui.setup {
    -- Set icons to characters that are more likely to work in every terminal.
    --    Feel free to remove or use ones that you like more! :)
    --    Don't feel like these are good choices.
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  }

  -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
  vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close

  -- Install golang specific config
  require('dap-go').setup()
end)

require 'custom.config.options'
require 'custom.config.keymaps'
require 'custom.config.autocmds'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
