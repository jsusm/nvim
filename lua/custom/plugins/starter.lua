local M = {}
local kitkat =
[[ /\_/\
( o.o )
 > ^ < ]]

M.setup = function()
  local starter = require 'mini.starter'
  starter.setup {
    header = function()
      return kitkat
    end,
    items = {
      starter.sections.recent_files(5, true, false),
      starter.sections.recent_files(5, false, true),
      starter.sections.sessions(5, true),
    },
    content_hooks = {
      starter.gen_hook.indexing('all', { 'Sessions' }),
      starter.gen_hook.adding_bullet '» ',
      starter.gen_hook.aligning('center', 'center'),
    },
    footer = '\n',
  }
end

return M
