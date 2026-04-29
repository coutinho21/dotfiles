return {
  "akinsho/bufferline.nvim",
  version = "*", -- Highly recommended by the plugin author to use the latest stable release
  dependencies = "nvim-tree/nvim-web-devicons",
  
  -- Keybinds to easily hop between your open tabs
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
    { "<leader>x", "<cmd>bdelete<cr>", desc = "Close Current Buffer" },
  },

  opts = {
    options = {
      mode = "buffers", -- Turns your open buffers into tabs
      diagnostics = "nvim_lsp", -- Optional: shows error/warning icons right in the tab!
      always_show_bufferline = true,
      
      -- Makes the tabs look a bit cleaner and more modern
      show_buffer_close_icons = true,
      show_close_icon = false,
    },
  },
}
