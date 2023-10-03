local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    -- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.lang.json" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
    -- import/override with your plugins
    { "nvim-tree/nvim-tree.lua" },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "BurntSushi/ripgrep" },
    },
    { "BurntSushi/ripgrep" },
    { "catppuccin/nvim",                 name = "catppuccin", priority = 1000 },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "ThePrimeagen/harpoon" },
    { "mbbill/undotree" },
    { "tpope/vim-fugitive" },
    {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
    },
    -- { "ms-jpq/chadtree",                  build = ":CHADdeps" },
    { "NvChad/nvim-colorizer.lua" },
    { "ggandor/leap.nvim" },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
    },
    {
      "okuuva/auto-save.nvim",
      cmd = "ASToggle",                         -- optional for lazy loading on command
      event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
      opts = {
        -- your config goes here
        -- or just leave it empty :)
      },
    },
    { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" }, },

    { "hkupty/nvimux" },
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      opts = {} -- this is equalent to setup({}) function
    },
    {
      "utilyre/sentiment.nvim",
      version = "*",
      event = "VeryLazy", -- keep for lazy loading
      opts = {
        -- config
      },
      init = function()
        -- `matchparen.vim` needs to be disabled manually in case of lazy loading
        vim.g.loaded_matchparen = 1
      end,
    },
    {
      "rmagatti/auto-session",
      config = function()
        require("auto-session").setup({
          auto_session_root_dir = vim.fn.getcwd()
        })
        -- vim.cmd.SessionRestore()
      end
    },
    { 'nvim-lualine/lualine.nvim',          dependencies = { 'kyazdani42/nvim-web-devicons' } },

    -- Keep inside to be notified of updates
    {
      "esensar/nvim-dev-container",
      init = function()
        require("devcontainer").setup({
          autocommands = { init = false, clean = false, update = true, },
          attach_mounts = {
            always = true,
            neovim_config = { enabled = true, options = {} },
            neovim_data = { enabled = true, options = {} },
            neovim_state = { enabled = true, options = {} },
          }
        })
      end
    },

    -- LSP Support
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    -- LSP Autocompletion
    { 'VonHeikemen/lsp-zero.nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-nvim-lua' },
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
    { 'hrsh7th/nvim-cmp' },
    { 'kosayoda/nvim-lightbulb' },
    { 'weilbith/nvim-code-action-menu' },
    { "folke/neodev.nvim",                  opts = {} },

    -- LSP Snippets
    { 'L3MON4D3/LuaSnip' },
    {
      'kikito/inspect.lua',
      name = "inspect",
      build =
      "mkdir lua && cp *.lua lua"
    },

    -- DAP Support
    { 'mfussenegger/nvim-dap' },
    { 'theHamsta/nvim-dap-virtual-text' },
    { 'jay-babu/mason-nvim-dap.nvim' },
    { 'rcarriga/nvim-dap-ui' },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
