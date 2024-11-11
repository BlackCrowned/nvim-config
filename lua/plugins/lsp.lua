-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  -- add any options here, or leave empty to use the default settings
})

local lsp_zero = require('lsp-zero')

-- Default keybindings
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({ buffer = bufnr })
  vim.keymap.set("n", "<leader>.", vim.cmd.CodeActionMenu)
end)

-- Code Actions
require("nvim-lightbulb").setup({
  autocmd = { enabled = true }
})

-- Autocomplete Setup
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
local cmp_format = require('lsp-zero').cmp_format()
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert', 'preview' }
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
  },
  --- (Optional) Show source name in completion menu
  formatting = cmp_format,
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({ select = false }),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
    ['<C-.>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})

-- Insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

-- Setup available LSPs & DAPs
require('mason').setup({})
require("mason-nvim-dap").setup({
  automatic_installation = true,
  ensure_installed = { "delve" },
  handlers = {},
})
require('mason-lspconfig').setup({
  ensure_installed = { "lua_ls", "svelte", "ts_ls" },
  handlers = {
    lsp_zero.default_setup,
    --     lua_ls = function()
    --       -- local lua_opts = lsp_zero.nvim_lua_ls()
    --       local lua_opts = {
    --         settings = {
    --           Lua = {
    --             completion = {
    --               workspaceWord = false,
    --             },
    --             diagnostics = {
    --               -- Get the language server to recognize the `vim` global
    --               globals = { "vim" },
    --             },
    --             window = {
    --               statusBar = true,
    --             },
    --             workspace = {
    --               -- Make the server aware of Neovim runtime files,
    --               -- see also https://github.com/LuaLS/lua-language-server/wiki/Libraries#link-to-workspace .
    --               -- Lua-dev.nvim also has similar settings for lua ls, https://github.com/folke/neodev.nvim/blob/main/lua/neodev/luals.lua .
    --               library = vim.api.nvim_get_runtime_file('', true),
    --               checkThirdParty = false,
    --               maxPreload = 2000,
    --               preloadFileSize = 50000,
    --             },
    --           },
    --         },
    --       }
    --       require('lspconfig').lua_ls.setup(lua_opts)
    --     end,
  },
})
