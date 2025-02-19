require "nvchad.mappings"
local M = {}
local dev_python = require "dev_python"
local map = vim.keymap.set

map("n", "<leader>gn", "<cmd> Neogit <cr>", { desc = "Neogit open in a new tab" })
map("n", "<leader>tt", "<cmd> tabNext <cr>", { desc = "Tab go to Next" })
map("n", "<leader>tn", "<cmd> tabNext <cr>", { desc = "Tab go to Next" })
map("n", "<leader>tp", "<cmd> tabprevious <cr>", { desc = "Tab go to previous" })
map("n", "<leader>td", "<cmd> Telescope diagnostics <cr>", { desc = "Telescope LSP diagnostics" })

-- Python Development Mappings
map("n", "<leader>pf", function()
  dev_python.run_flake8_on_current_file()
end, { desc = "Python run flake8 on current file" })

map("n", "<leader>pm", function()
  dev_python.run_mypy()
end, { desc = "Python run mypy" })

map("n", "<leader>pp", function()
  dev_python.run_pre_commit()
end, { desc = "Python run pre-commit" })

-- Sourced from the original commit
-- Write to buffer before insert of visual mode
map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "DAP Add breakpoint at line",
    },

    ["<leader>dus"] = {
      function()
        local widgets = require "dap.ui.widgets"
        local sidebar = widgets.sidebar(widgets.scopes)
        sidebar.open()
      end,
      "DAP Open debugging sidebar",
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
      "DAP Run nearest test w/ debugger",
    },
  },
}

return M
