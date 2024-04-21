local M = {}
M.setup = function()
  vim.cmd[[ call fzf_mru#mrufiles#init() ]]
end

return M
