local M = {}

function M.run_mypy()
  local cmd = "./.venv/bin/mypy --config-file=pyproject.toml"
  local output = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    vim.fn.setqflist({}, "r", { title = "mypy errors", lines = output })
    vim.cmd "copen" -- Open the quickfix list if there are errors
  else
    vim.cmd "cclose"
    print "No mypy errors!"
  end
end

function M.run_flake8_on_current_file()
  local file = vim.fn.expand "%:p" -- Get the full path of the current file
  local cmd = "./.venv/bin/flake8 " .. file
  local output = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    vim.fn.setqflist({}, "r", { title = "flake8 errors", lines = output })
    vim.cmd "copen" -- Open the quickfix list if there are errors
  else
    vim.cmd "cclose"
    print "No flake8 errors!"
  end
end

-- broken ansi colors are still dispayed
function M.run_pre_commit()
  local cmd = "PRE_COMMIT_COLOR=never ./.venv/bin/pre-commit run"
  local output = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    vim.fn.setqflist({}, "r", { title = "pre-commit errors", lines = output })
    vim.cmd "copen" -- Open the quickfix list if there are errors
  else
    vim.cmd "cclose"
    print "No pre-commit errors!"
  end
end

return M
