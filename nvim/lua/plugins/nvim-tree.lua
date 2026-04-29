return {
  -- file explorer
  "nvim-tree/nvim-tree.lua",
  lazy = false, -- This belongs to lazy.nvim, so it goes here

    keys = {
    -- Toggles the tree open and closed
    { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle File Explorer" },
    
    -- (Optional) If the tree is open but you are in a file, this jumps your cursor to the tree
    { "<leader>o", "<cmd>NvimTreeFocus<CR>", desc = "Focus File Explorer" },
  },
  config = function()
    require("nvim-tree").setup({
      filters = {
        dotfiles = false,
      },
      -- 'lazy' has been removed from here
    })
  end,
}
