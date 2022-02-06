-- This is an example init file , its supposed to be placed in /lua/custom/

-- This is where your custom modules and plugins go.
-- Please check NvChad docs if you're totally new to nvchad + dont know lua!!

-- MAPPINGS
local map = require("core.utils").map

map("n", "<leader>cc", ":Telescope <CR>")
map("n", "<leader>q", ":q <CR>")
vim.cmd[[colorscheme catppuccin]]
vim.cmd[[set rnu]]
-- NOTE: the 4th argument in the map function can be a table i.e options but its most likely un-needed so dont worry about it

-- Install plugins
local customPlugins = require "core.customPlugins"

customPlugins.add(function(use)
   use {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
   }

   use {
      "williamboman/nvim-lsp-installer",
   }
   
   use 'neovim/nvim-lspconfig'
   
   use({
	"catppuccin/nvim",
	as = "catppuccin"
   })

   
   use {
      "mhinz/vim-startify",
      after = "packer.nvim",
   }

      -- load luasnips + cmp related in insert mode only
    use {
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
   }

   use {
      "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
      config = function()
         require "custom.plugins.cmp"
      end,
   }

   use {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         local luasnip = require "luasnip"
         luasnip.config.set_config {
            history = true,
            updateevents = "TextChanged,TextChangedI",
         }
         require("luasnip/loaders/from_vscode").load()
      end,
   }

   use {
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
   }

   use {
      "hrsh7th/cmp-nvim-lua",
      after = "cmp_luasnip",
   }

   use {
      "hrsh7th/cmp-nvim-lsp",
      after = "cmp-nvim-lua",
   }

   use {
      "hrsh7th/cmp-buffer",
      after = "cmp-nvim-lsp",
   }

   use {
      "hrsh7th/cmp-path",
      after = "cmp-buffer",
   }

   use {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
         local autopairs = require "nvim-autopairs"
         local cmp_autopairs = require "nvim-autopairs.completion.cmp"

         autopairs.setup { fast_wrap = {} }

         local cmp = require "cmp"
         cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
   }
   use {
      "jose-elias-alvarez/null-ls.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("custom.plugins.null-ls").setup()
      end,
   }
   use 'habamax/vim-godot'
   use 'andweeb/presence.nvim'
   use 'Shougo/deoplete.nvim'
   use 'deoplete-plugins/deoplete-lsp'
-- load it after nvim-lspconfig , since we'll use some lspconfig stuff in the null-ls config!
end)



-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event','cmd' fields)
-- see: https://github.com/wbthomason/packer.nvim
-- https://nvchad.github.io/config/walkthrough
