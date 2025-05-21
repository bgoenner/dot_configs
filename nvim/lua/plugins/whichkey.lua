return {
	"folke/which-key.nvim",
	opts = {
		-- configuration
	},
	keys = {
    {
      "<Leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
