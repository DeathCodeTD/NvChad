local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   -- lspservers with default config
   local servers = { "html", "cssls", "clangd" }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
      }
   end
end

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)


local lsp_installer_servers = require('nvim-lsp-installer.servers')

local servers = {
    "rust_analyzer",
    "clangd",
    "pyright",
}

-- Loop through the servers listed above.
for _, server_name in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)
    if server_available then
        server:on_ready(function ()
            -- When this particular server is ready (i.e. when installation is finished or the server is already installed),
            -- this function will be invoked. Make sure not to use the "catch-all" lsp_installer.on_server_ready()
            -- function to set up servers, to avoid doing setting up a server twice.
            local opts = {}
            server:setup(opts)
        end)
        if not server:is_installed() then
            -- Queue the server to be installed.
            server:install()
        end
    end
end

vim.cmd[[set completeopt=menu,menuone,noselect]]

require'lspconfig'.gdscript.setup{capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())}

local cmp = require'cmp'

cmp.setup({
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }
})


vim.cmd[[set completeopt=menu,menuone,noselect]]

require'lspconfig'.gdscript.setup{capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())}

local cmp = require'cmp'

cmp.setup({
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }
})
local lspconfig = require'lspconfig'
lspconfig.gdscript.setup{
    cmd = {"netcat", "localhost", "6008"}
}

local configs = require 'lspconfig/configs'
local util = require 'lspconfig/util'

configs.ccls = {
  default_config = {
    cmd = { 'ccls' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
    root_dir = util.root_pattern('compile_commands.json', '.ccls', 'compile_flags.txt', '.git'),
    -- ccls does not support sending a null root directory
    single_file_support = false,
  },
  docs = {
    description = [[
https://github.com/MaskRay/ccls/wiki
ccls relies on a [JSON compilation database](https://clang.llvm.org/docs/JSONCompilationDatabase.html) specified
as compile_commands.json or, for simpler projects, a compile_flags.txt.
For details on how to automatically generate one using CMake look [here](https://cmake.org/cmake/help/latest/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html). Alternatively, you can use [Bear](https://github.com/rizsotto/Bear).
Customization options are passed to ccls at initialization time via init_options, a list of available options can be found [here](https://github.com/MaskRay/ccls/wiki/Customization#initialization-options). For example:
```lua
local lspconfig = require'lspconfig'
lspconfig.ccls.setup {
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
}
```
]],
    default_config = {
      root_dir = [[root_pattern("compile_commands.json", ".ccls", "compile_flags.txt", ".git") or dirname]],
    },
  },
}
return M


