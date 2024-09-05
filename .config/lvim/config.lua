lvim.leader = "space"

-- Keybindings for moving selected lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keybindings for clipboard operations
vim.keymap.set("x", "<leader>p", [["_dP]])  -- Paste without replacing the default register
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])  -- Yank to the system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])  -- Yank the entire line to the system clipboard
lvim.keys.normal_mode["<C-c>"] = ":ColorizerToggle<CR>"
lvim.keys.normal_mode["<space>ts"] = ":%s/\\s\\+$//e<CR>"

lvim.plugins = {

  {'norcalli/nvim-colorizer.lua',
    config = function()
      require'colorizer'.setup()
    end,
  },

 { "ellisonleao/gruvbox.nvim",
    priority = 1000 ,
    config = true,
    opts = ...
  }
}

lvim.colorscheme = "gruvbox"
