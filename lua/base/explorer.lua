return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "s1n7ax/nvim-window-picker",
  },
  opts = {
    event_handlers = {
      {
        event = "file_opened",
        handler = function(_)
          vim.cmd "NeoTreeClose"
        end,
        id = "close-at-the-open"
      }
    }
  },
  keys = {
    { "<leader>ef", "<cmd>Neotree position=left toggle=true<cr>",                   desc = "Files" },
    { "<leader>eb", "<cmd>Neotree position=left toggle=true source=buffers<cr>",    desc = "Buffers" },
    { "<leader>eg", "<cmd>Neotree position=left toggle=true source=git_status<cr>", desc = "Git Status" },
    { "<leader>er", "<cmd>Neotree reveal %p<cr>",                                   desc = "Reveal File" },
  },
}

