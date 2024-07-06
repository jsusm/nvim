vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

require('mini.bufremove').setup()

vim.keymap.set('n', '<S-l>', '<cmd>bnext<cr>', { desc = 'Move to the next buffer' })
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<cr>', { desc = 'Move to the previous buffer' })
vim.keymap.set('n', '<leader>bd', MiniBufremove.delete, {desc = "delete buffer"})

-- Pick things
local extra = require 'mini.extra'
extra.setup {}

local pick = require 'mini.pick'
pick.setup {}

vim.keymap.set('n', '<leader><leader>', pick.builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>so', extra.pickers.oldfiles, { desc = '[S]earch [O]ld files' })
vim.keymap.set('n', '<leader>sr', extra.pickers.registers, { desc = '[S]earch [R]egisters' })
vim.keymap.set('n', '<leader>s.', pick.builtin.resume, { desc = '[S]earch Resume' })
vim.keymap.set('n', '<leader>sh', pick.builtin.help, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sk', extra.pickers.keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sf', pick.builtin.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sw', pick.builtin.grep, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', pick.builtin.grep_live, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', extra.pickers.diagnostic, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sm', extra.pickers.marks, { desc = '[S]earch [M]arks' })
vim.keymap.set('n', '<leader>sch', extra.pickers.history, { desc = '[S]earch [C]ommand [H]istory'})

vim.keymap.set('n', '<leader>/', function()
  extra.pickers.buf_lines { scope = 'current' }
end, { desc = '[S]earch in current file' })

vim.keymap.set('n', '<leader>ss', function()
  extra.pickers.buf_lines { scope = 'all' }
end, { desc = '[S]earch in open files' })

-- Git
vim.keymap.set('n', '<leader>gb', function()
  extra.pickers.git_branches { scope = 'local' }
end, { desc = '[G]it [B]ranches' })

vim.keymap.set('n', '<leader>gc', function ()
  extra.pickers.git_commits()
end, { desc = '[G]it [C]ommits'})

vim.keymap.set('n', '<leader>gsm', function ()
  extra.pickers.git_files({ scope = 'modified'})
end, { desc = '[G]it [S]earch [M]odified'})

vim.keymap.set('n', '<leader>gsh', function ()
  extra.pickers.git_hunks()
end, {desc = '[G]it [S]earch [H]unks'})
