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

return { createSession = createSession }
