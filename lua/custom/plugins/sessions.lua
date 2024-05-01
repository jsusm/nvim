local M = {}

local function createSession()
  vim.ui.input({ prompt = 'Enter session name (default cwd): ' }, function(input)
    local session_name = input
    if input == nil or input == '' then
      session_name = vim.fn.getcwd()
      local dir = vim.split(session_name, "/", { trimempty = true })
      session_name = dir[#dir]
    end
    MiniSessions.write(session_name)
  end)
end

M.setup = function()
  require('mini.sessions').setup()
  vim.keymap.set('n', '<leader>ir', function()
    MiniSessions.select 'read'
  end, { desc = 'Session read' })
  vim.keymap.set('n', '<leader>id', function()
    MiniSessions.select 'delete'
  end, { desc = 'Session Delete' })
  vim.keymap.set('n', '<leader>iw', function()
    MiniSessions.select 'write'
  end, { desc = 'Session write' })
  vim.keymap.set('n', '<leader>in', createSession, { desc = 'Session write' })

end

return M
