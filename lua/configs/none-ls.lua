local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
	sources = {
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.yamlfix,
		-- null_ls.builtins.formatting.nixfmt,
		-- null_ls.builtins.diagnostics.eslint,
		-- null_ls.builtins.diagnostics.ruff,
		-- null_ls.builtins.formatting.gofumpt,
		-- null_ls.builtins.formatting.goimports_reviser,
		-- null_ls.builtins.formatting.golines,
		-- null_ls.builtins.formatting.autopep8,
		-- null_ls.builtins.diagnostics.flake8,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
}

return opts
