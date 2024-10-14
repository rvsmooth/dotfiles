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
  },

  {"neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    require("everforest").setup({
          background = "hard",
    })
  end,
  },

  { "Mofiqul/dracula.nvim",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,

  },
{
  'nvim-orgmode/orgmode',
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Setup orgmode
    require('orgmode').setup({
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',
    })

    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
    -- add ~org~ to ignore_install
    -- require('nvim-treesitter.configs').setup({
    --   ensure_installed = 'all',
    --   ignore_install = { 'org' },
    -- })
  end,
},
}

lvim.colorscheme = "dracula"
