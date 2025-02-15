require "nvchad.mappings"
local M = {}
local dev_python = require "dev_python"
local map = vim.keymap.set

map("n", "<leader>gn", "<cmd> Neogit <cr>", { desc = "Open Neogit" })

-- Python Development Mappings
map("n", "<leader>pf", function()
  dev_python.run_flake8_on_current_file()
end, { desc = "Run flake8 on current file" })

map("n", "<leader>pm", function()
  dev_python.run_mypy()
end, { desc = "Run mypy" })

map("n", "<leader>pp", function()
  dev_python.run_pre_commit()
end, { desc = "Run pre-commit" })

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },

    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "Open debugging sidebar",
    },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
      "Run nearest test w/ debugger",
    },
  },
}

return M
