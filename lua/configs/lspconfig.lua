local configs = require "nvchad.configs.lspconfig"

local mason_registry = require "mason-registry"

-- local vue_language_server_path = "/home/hermes/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
local vue_language_server_path = mason_registry.get_package("vue-language-server"):get_install_path()
  .. "/node_modules/@vue/language-server"

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = {
          globals = { "vim" }, -- Prevents 'undefined vim' warnings
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true), -- Load Neovim runtime files
        },
        telemetry = { enable = false },
      },
    },
  },
  html = {},
  bashls = {},
  dockerls = {},
  rnix = {},
  cssls = {},
  ltex = {
    settings = {
      ltex = { language = "en-US" },
    },
  },
  ts_ls = {
    {
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = vue_language_server_path,
            languages = { "javascript", "typescript", "vue" },
          },
        },
      },
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    },
  },

  volar = {
    init_options = {
      vue = {
        hybridMode = false,
      },
    },
  },

  pyright = {
    settings = {
      filetypes = { "python" },
      python = {
        analysis = {
          autoSearchPaths = true,
          typeCheckingMode = "strict",
          autoImportCompletions = true,
          useLibraryCodeForTypes = true,
        },
      },
    },

    before_init = function(_, config)
      -- This function sets the Python path dynamically based on the presence of a .venv directory
      local venv_path = vim.fn.getcwd() .. "/.venv/bin/python"
      if vim.fn.filereadable(venv_path) == 1 then
        config.settings.python.pythonPath = venv_path
      else
        config.settings.python.pythonPath = "/usr/bin/python3" -- Fallback global Python
      end
    end,
  },
}

-- Dynamically attack capbilities to all configured servers
for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end
