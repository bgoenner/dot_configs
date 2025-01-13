local keymap = vim.keymap

local config = function()
	-- local magma = require("")

	local opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "<Leader>mi", "<cmd>MagmaInit<CR>", opts)
	vim.keymap.set("n", "<Leader>mip", "<cmd>MagmaInit python3<CR>", opts)
	vim.keymap.set("n", "<Leader>mir", "<cmd>MagmaInit R<CR>", opts)

	-- other keybindings
	vim.keymap.set("n", "<Leader>eo", "<cmd>MagmaEvaluateOperator<CR>")
	vim.keymap.set("n", "<Leader>el", "<cmd>MagmaEvaluateLine<CR>")
	vim.keymap.set("n", "<Leader>ev", "<cmd>MagmaEvaluateVisual<CR>")
	vim.keymap.set("n", "<Leader>er", "<cmd>MagmaReevaluateCell<CR>")
	vim.keymap.set("n", "<Leader>mD", "<cmd>MagmaDelete<CR>")
	vim.keymap.set("n", "<Leader>mO", "<cmd>MagmaShowOutput<CR>")
end

return {
	"dccsillag/magma-nvim",
	lazy = false,
	config = config,
	dependencies = {
		"neovim/pynvim",
	},
}
