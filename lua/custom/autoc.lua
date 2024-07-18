vim.api.nvim_create_autocmd({ 'TermOpen' }, {
  group = vim.api.nvim_create_augroup('term_open', { clear = true }),
  callback = function(event)
    vim.cmd 'setlocal nonumber'
    vim.cmd 'setlocal norelativenumber'
    vim.cmd 'setlocal signcolumn=no'
    vim.cmd 'startinsert!'
    vim.cmd 'set cmdheight=1'

    vim.api.nvim_buf_set_name(event.buf, 'term ' .. event.buf)

    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})
