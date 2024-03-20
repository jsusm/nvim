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
  require('mini.statusline').setup()
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
  add {
    source = 'folke/tokyonight.nvim',
  }
  vim.cmd.colorscheme 'tokyonight-night'
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
  require('luasnip.loaders.from_vscode').lazy_load()

  -- See `:help cmp`
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'
  luasnip.config.setup {}

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    completion = { completeopt = 'menu,menuone,noinsert' },

    -- For an understanding of why these mappings were
    -- chosen, you will need to read `:help ins-completion`
    --
    -- No, but seriously. Please read `:help ins-completion`, it is really good!
    mapping = cmp.mapping.preset.insert {
      -- Select the [n]ext item
      ['<C-n>'] = cmp.mapping.select_next_item(),
      -- Select the [p]revious item
      ['<C-p>'] = cmp.mapping.select_prev_item(),

      -- Scroll the documentation window [b]ack / [f]orward
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),

      -- Accept ([y]es) the completion.
      --  This will auto-import if your LSP supports it.
      --  This will expand snippets if the LSP sent a snippet.
      ['<C-y>'] = cmp.mapping.confirm { select = true },

      -- Manually trigger a completion from nvim-cmp.
      --  Generally you don't need this, because nvim-cmp will display
      --  completions whenever it has completion options available.
      ['<C-Space>'] = cmp.mapping.complete {},

      -- Think of <c-l> as moving to the right of your snippet expansion.
      --  So if you have a snippet that's like:
      --  function $name($args)
      --    $body
      --  end
      --
      -- <c-l> will move you to the right of each of the expansion locations.
      -- <c-h> is similar, except moving you backwards.
      ['<C-l>'] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { 'i', 's' }),
      ['<C-h>'] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { 'i', 's' }),

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
    },
  }
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

  require('neodev').setup()
  require('inlay-hints').setup {
    autocmd = { enable = false },
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Jump to the definition of the word under your cursor.
      --  This is where a variable was first declared, or where a function is defined, etc.
      --  To jump back, press <C-t>.
      map('gd', '<cmd>Pick lsp scope="definition"<cr>', '[G]oto [D]efinition')

      -- Find references for the word under your cursor.
      map('gr', '<cmd>Pick lsp scope="references"<cr>', '[G]oto [R]eferences')

      -- Jump to the implementation of the word under your cursor.
      --  Useful when your language has ways of declaring types without an actual implementation.
      map('gI', '<cmd>Pick lsp scope="implementation"<cr>', '[G]oto [I]mplementation')

      -- Jump to the type of the word under your cursor.
      --  Useful when you're not sure what type a variable is and you want to see
      --  the definition of its *type*, not where it was *defined*.
      map('<leader>D', '<cmd>Pick lsp scope="definition"<cr>', 'Type [D]efinition')

      -- Fuzzy find all the symbols in your current document.
      --  Symbols are things like variables, functions, types, etc.
      map('<leader>ds', '<cmd>Pick lsp scope="document_symbol"<cr>', '[D]ocument [S]ymbols')

      -- Fuzzy find all the symbols in your current workspace.
      --  Similar to document symbols, except searches over your entire project.
      map('<leader>ws', '<cmd>Pick lsp scope="workspace_symbol"<cr>', '[W]orkspace [S]ymbols')

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      -- Opens a popup that displays documentation about the word under your cursor
      --  See `:help K` for why this keymap.
      map('K', vim.lsp.buf.hover, 'Hover Documentation')

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- Toggle inlay hints
      map('<leader>li', '<cmd>InlayHintsToggle<cr>', 'Togg[l]e [I]nlay hints')

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end,
  })

  -- LSP servers and clients are able to communicate to each other what features they support.
  --  By default, Neovim doesn't support everything that is in the LSP specification.
  --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
  --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --
  --  Add any additional override configuration in the following tables. Available keys are:
  --  - cmd (table): Override the default command used to start the server
  --  - filetypes (table): Override the default list of associated filetypes for the server
  --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
  --  - settings (table): Override the default settings passed when initializing the server.
  --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
  local servers = {
    clangd = {},
    gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
    --
    -- Some languages (like typescript) have entire language plugins that can be useful:
    --    https://github.com/pmizio/typescript-tools.nvim
    --
    -- But for many setups, the LSP (`tsserver`) will work just fine
    tsserver = {
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = false,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
        },
      },
    },
    --

    lua_ls = {
      -- cmd = {...},
      -- filetypes = { ...},
      -- capabilities = {},
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          hint = {
            enable = true,
          },
          -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { 'missing-fields' } },
        },
      },
    },
  }

  -- Ensure the servers and tools above are installed
  --  To check the current status of installed tools and/or manually install
  --  other tools, you can run
  --    :Mason
  --
  --  You can press `g?` for help in this menu.
  require('mason').setup()

  -- You can add other tools here that you want Mason to install
  -- for you, so that they are available from within Neovim.
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    'stylua', -- Used to format Lua code
  })
  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  require('mason-lspconfig').setup {
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        -- This handles overriding only values explicitly passed
        -- by the server configuration above. Useful when disabling
        -- certain features of an LSP (for example, turning off formatting for tsserver)
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        require('lspconfig')[server_name].setup(server)
      end,
    },
  }
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
      local disable_filetypes = { c = true, cpp = true }
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
      -- javascript = { { "prettierd", "prettier" } },
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
  }
end)

require 'custom.config.options'
require 'custom.config.keymaps'
require 'custom.config.autocmds'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
