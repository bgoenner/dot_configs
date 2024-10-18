local keymap = vim.keymap

local config = function()

  -- local magma = require("")

	local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "<Leader>mi",  "<cmd>MagmaInit<CR>", opts)
  vim.keymap.set("n", "<Leader>mip", "<cmd>MagmaInit python3<CR>", opts)
  vim.keymap.set("n", "<Leader>mir", "<cmd>MagmaInit R<CR>", opts)

end

return {
  "dccsillag/magma-nvim",
  lazy=false,
  config = config,
	dependencies = {
    "neovim/pynvim"
  }

}
