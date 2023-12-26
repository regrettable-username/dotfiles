-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local result = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  -- Debugging: Print any error messages
  if vim.v.shell_error ~= 0 then
    print("Error cloning lazy.nvim: ", result)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 400
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  'numToStr/Comment.nvim',
  'nvim-telescope/telescope.nvim',
  'nvim-treesitter/nvim-treesitter',
  'nvim-tree/nvim-tree.lua',
  'RRethy/vim-illuminate',
  'nvim-lua/plenary.nvim',  -- Dependency for Telescope

  { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }, -- Optional for better performance

  'neovim/nvim-lspconfig',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'williamboman/nvim-lsp-installer',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
  'ziglang/zig.vim',
  {'nvim-lualine/lualine.nvim'},
  {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {'akinsho/toggleterm.nvim', version = "*", config = true},
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },

  {
     "zbirenbaum/copilot-cmp",
     after = { "copilot.lua" },
     config = function ()
       require("copilot_cmp").setup()
     end
  },
  {
  "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "op read op://private/OpenAIKeys/credential --no-newline",
        openai_params = {
          model = "gpt-4-1106-preview",
        }
      })
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    'xbase-lab/xbase',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    build = "make install",
    config = function()
      require 'xbase'.setup {
        log_level = vim.log.levels.DEBUG,
        simctl = {
          iOS = {
            "iPhone 15 Pro"
          }
        },
        mappings = {
          build_picker = 0,
          run_picker = 0,
          watch_picker = 0,
          all_picker = 0,
          toggle_split_log_buffer = 0,
          toggle_vsplit_log_buffer = 0
        }
      }
    end
  }
})

-- Setup Toggleterm
require("toggleterm").setup{
  size = 10,
  open_mapping = [[<c-b>]],
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = 'horizontal',
}

-- Setup copilot
require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

-- Setup mason for lsp help 
require("mason").setup()
require("mason-lspconfig").setup()

-- Setup comment for line commenting
require("Comment").setup()

-- change the highlight style
vim.api.nvim_set_hl(0, "IlluminatedWordText", { underdouble = true })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underdouble = true })
vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underdouble = true })

--- auto update the highlight style on colorscheme change
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_set_hl(0, "IlluminatedWordText", { underdouble = true })
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", { underdouble = true })
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { underdouble = true })
  end
})

-- Setup nvim tree
local function tree_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  on_attach = tree_on_attach,
})

-- LSP config 
require('nvim-lsp-installer').setup {
  diagnostics = "nvim_lsp",
}
local lspconfig = require('lspconfig')

-- Define a table to hold specific configuration for each server
local server_settings = {
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {'vim'},
                },
                workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    clangd = {
      cmd = {
          "clangd",
          "--offset-encoding=utf-16",
      },
    },
    sourcekit = {
      on_attach = function(_, bufnr)
        vim.keymap.set('n', '<leader>dp', require "xbase.pickers.builtin".actions, { desc = "XBase picker" })

        local opts = {noremap = true, silent = true}
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
        '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '$',
        '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.keymap.set('n', '<leader>dl', function()
          require "xbase.logger".toggle(false, true)
        end, { desc = "XBase logger" })
      end,
      filetypes = { "swift" },
      root_dir = lspconfig.util.root_pattern("*.xcodeproj", "*.xcworkspace", "Package.swift", ".git", "project.yml", "Project.swift"),
      cmd = {
        "xcrun",
        "sourcekit-lsp",
        "--log-level",
        "debug"
      }
    },
    -- Add specific settings for other servers here if needed
}

-- List of servers you want to setup
local servers = {'pyright', 'tsserver', 'rust_analyzer', 'lua_ls', 'zls', 'clangd', 'sourcekit'}

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup(vim.tbl_deep_extend("force", {
        on_attach = function(_, bufnr)
            -- Key mappings for LSP functions
            local opts = {noremap = true, silent = true}
            vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
            '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
            vim.api.nvim_buf_set_keymap(bufnr, 'n', '$',
            '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            -- Add more keybindings as needed
        end,
        flags = {
            debounce_text_changes = 150,
        },
    }, server_settings[lsp] or {})) -- Merge specific server settings
end

local cmp = require('cmp')
cmp.setup({
    snippet = {
        -- REQUIRED for `nvim-cmp` snippet support
        -- expand = function(args)
            -- Configure your snippet engine here; `vim-vsnip` is a common choice
        --end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- Add other mappings as needed
    }),
    sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = 'nvim_lsp', group_index = 2 },
        -- Add other sources as needed
    }),
})

-- Illuminate config for highlighting words
require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
    -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    -- See `:help mode()` for possible values
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
    -- See `:help mode()` for possible values
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
    -- large_file_cutoff: number of lines at which to use large_file_config
    -- The `under_cursor` option is disabled when this cutoff is hit
    large_file_cutoff = nil,
    -- large_file_config: config to use for large files (based on large_file_cutoff).
    -- Supports the same keys passed to .configure
    -- If nil, vim-illuminate will be disabled for large files.
    large_file_overrides = nil,
    -- min_count_to_highlight: minimum number of matches required to perform highlighting
    min_count_to_highlight = 1,
    -- should_enable: a callback that overrides all other settings to
    -- enable/disable illumination. This will be called a lot so don't do
    -- anything expensive in it.
    should_enable = function() return true end,
    -- case_insensitive_regex: sets regex case sensitivity
    case_insensitive_regex = false,
})

-- Bufferline config
require("bufferline").setup()
--lualine 
require('lualine').setup {}
vim.opt.termguicolors = true

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.number = true
vim.o.clipboard = "unnamedplus"
vim.o.hlsearch = false
vim.o.mouse = 'a'
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.cmd [[
  augroup LineNumbers
    autocmd!
    autocmd InsertEnter * set relativenumber
    autocmd InsertLeave * set norelativenumber
  augroup END
]]

-- Set absolute line numbers by default

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Escape mappings
map('i', 'jk', '<Esc>', opts)
map('i', 'kj', '<Esc>', opts)

-- Navigation mappings
map('n', 'J', '}', opts)
map('n', 'K', '{', opts)
map('n', 'L', '$', opts)
map('n', 'H', '^', opts)

-- Setup whichkey
local wk = require("which-key")

wk.register({
  ["dL"] = { "d$", "Delete to end of line" },
  ["dH"] = { "d^", "Delete to start of line" },
})

wk.register({
  ["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", "File Tree" },
  ["<leader>a"] = { "O<Esc>", "Insert Line Above" },
  ["<leader>s"] = { "o<Esc>k", "Insert Line Below" },
  ["<leader>d"] = { "o<Esc>kO<Esc>j", "Pad Line" },
})

wk.register({
  ["<leader>c"] = { name = "+nvim config" },
  ["<leader>cc"] = { "<cmd>edit ~/.config/nvim/init.lua<cr>", "Edit init.lua" },
})
-- tabs
wk.register({
  ["<leader>["] = { "<cmd>bp<cr>", "Prev. Tab" },
  ["<leader>]"] = { "<cmd>bn<cr>", "Next Tab" },
  ["<leader>q"] = { "<cmd>bd<cr>", "Close Tab" },
})

wk.register({
  ["<leader>f"] = { name = "+File" },
  ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Find File" },
  ["<leader>fr"] = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
  ["<leader>fb"] = { "<cmd>Telescope buffers<cr>", "Open Buffer" },
  ["<leader>fn"] = { "<cmd>enew<cr>", "New File" },
  ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Live Grep"},
})

wk.register({
  ["<leader>l"] = { name = "+LSP" },
  ["<leader>lk"] = { "<cmd>Telescope lsp_workspace_symbols<cr>", "Find Symbols" },
  ["<leader>ld"] = { "<cmd>Telescope lsp_document_symbols<cr>", "Find Document Symbols" },
  ["<leader>lf"] = { '<cmd>lua require("telescope.builtin").lsp_document_symbols({ symbols = { "method" } })<CR>', "Find Functions" },
  ["<leader>lr"] = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Replace Document Symbols" },
})

wk.register({
  ["<leader>j"] = { name = "+ChatGPT" },
  ["<leader>jj"] = { "<cmd>ChatGPT<cr>", "Start ChatGPT" },
  ["<leader>ji"] = { "<cmd>ChatGPTEditWithInstructions<cr>", "Instruct Edit", mode = {"n", "v"} },
  ["<leader>je"] = { "<cmd>ChatGPTRun explain_code<cr>", "Explain", mode = {"n", "v"} },
  ["<leader>jc"] = { "<cmd>ChatGPTRun complete_code<cr>", "Complete", mode = {"n", "v"} },
  ["<leader>jf"] = { "<cmd>ChatGPTRun fix_bugs<cr>", "Complete", mode = {"n", "v"} },
  ["<leader>jt"] = { "<cmd>ChatGPTRun add_tests<cr>", "Complete", mode = {"n", "v"} },
})


vim.cmd("colorscheme catppuccin")
