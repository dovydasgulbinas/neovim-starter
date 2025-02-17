-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

-- probably not needed two lones below
-- M.plugins = "plugins"
-- M.mappings = require "mappings"

M.base46 = {
  theme = "doomchad",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = { load_on_startup = true }
M.ui = {
  tabufline = {
    lazyload = false,
  },
}

M.term = {
  float = {
    relative = "editor",
    row = 0.18,
    col = 0.1,
    width = 0.8,
    height = 0.64,
    border = "single",
  },
}

return M
