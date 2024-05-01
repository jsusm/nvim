local M = {}

M.setup = function()
  local extra = require 'mini.extra'
  extra.setup {}

  -- Pick things
  local pick = require 'mini.pick'
  pick.setup {}

  vim.keymap.set('n', '<leader><leader>', pick.builtin.buffers, { desc = '[ ] Find existing buffers' })
  vim.keymap.set('n', '<leader>s.', extra.pickers.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
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

  vim.keymap.set('n', '<leader>ss', function()
    extra.pickers.buf_lines { scope = 'all' }
  end, { desc = 'Search in open files' })
end

return M
