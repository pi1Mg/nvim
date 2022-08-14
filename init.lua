-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use 'joshdick/onedark.vim' -- Theme inspired by Atom
  use 'itchyny/lightline.vim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin

  -- MN additions.
  -- use { 'louchen1990/rainbow' }
  use { 'p00f/nvim-ts-rainbow' }
  use { 'tpope/vim-surround' }
  use { 'rrethy/vim-hexokinase' }
  -- use {'rrethy/vim-hexokinase', run = 'cd ~/.local/share/nvim/site/pack/packer/start/vim-hexokinase && make hexokinase'}
  -- use { 'norcalli/nvim-colorizer.lua' }
  -- What does vim-impaired, vim-commentary do?
  use { 'tpope/vim-unimpaired' }
  use { 'plasticboy/vim-markdown' }
  use { 'windwp/nvim-autopairs' }
  use { 's1n7ax/nvim-terminal' }
  use { 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim' }
  use { 'wellle/targets.vim'}
  use { 'untitled-ai/jupyter_ascending.vim' }
  -- use { 'bredl/nvim-ipy' }
  -- Themes.
  use { 'NLKNguyen/papercolor-theme' } -- vim
  use { 'Th3Whit3Wolf/one-nvim' } -- vim
  use { 'jsit/toast.vim' } -- vim
  -- use { 'tjdevries/colorbuddy.vim' } -- vim
  -- use { 'Th3Whit3Wolf/onebuddy' } -- vim
  -- use { 'kaicataldo/material.vim', { 'branch': 'main' } }
  use { 'rafamadriz/neon' }
  use { 'Th3Whit3Wolf/space-nvim' }
  use { 'sainnhe/everforest' }
  use { 'sainnhe/edge' }
  use { 'Pocco81/Catppuccino.nvim' }
  use { 'ishan9299/modus-theme-vim'}
  use { "adisen99/codeschool.nvim", requires = {"rktjmp/lush.nvim"} }
  use { 'rose-pine/neovim' }
  use { 'rakr/vim-one' }
end)

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = 'nosplit'

--Set highlight on search
vim.o.hlsearch = false

--Make line numbers default
vim.wo.number = true

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2

-- Remap space as leader key.
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true })

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_char_highlight = 'LineNr'
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
local km = vim.api.nvim_set_keymap
--Add leader shortcuts
km(
    'n', '<leader><space>',
    [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
    { noremap = true, silent = true }
)
km(
    'n', '<leader>sf',
    [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
    { noremap = true, silent = true }
)
km(
    'n', '<leader>sb',
    [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
    { noremap = true, silent = true }
)
km(
    'n', '<leader>sh',
    [[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
    { noremap = true, silent = true }
)
km(
    'n',
    '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]],
    { noremap = true, silent = true }
)
km(
    'n', '<leader>sd',
    [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
    { noremap = true, silent = true }
)
km('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
km('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
km('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
    -- link = { TSError = 'Normal'}  -- how to disable syntax checking in i?
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- LSP settings
local nvim_lsp = require 'lspconfig'
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  local km = vim.api.nvim_buf_set_keymap
  km(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  km(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  km(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  km(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  km(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  km(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  km(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  km(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  km(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  km(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  km(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  km(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- km(bufnr, 'v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  km(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  km(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  km(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  km(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  km(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Example custom server
local sumneko_root_path = vim.fn.getenv 'HOME' .. '/.local/bin/sumneko_lua' -- Change to your sumneko root installation
local sumneko_binary = sumneko_root_path .. '/bin/linux/lua-language-server'

-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
local luasnip = require 'luasnip'

-- Combine luasnip with nvim-cmp.
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  completion = {
    autocomplete = false,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- nvim-autopairs setup
require('nvim-autopairs').setup{}


-- MN translation of vimrc to init.lua --------------------------------------

-- Tab settings (use `:h et` to see is it bound to the buffer).
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
-- Set relative line numbers and no number.
-- vim.wo.nonumber = true
vim.api.nvim_command('set nonumber')
vim.api.nvim_command('set rnu')

-- Set cursor line
vim.wo.cursorline = true
vim.wo.cursorlineopt = 'line' -- 'line' 'number'
vim.api.nvim_command([[ au BufLeave * setlocal nocursorcolumn ]])

-- Get some room when scrolling on the edges of the screen.
vim.opt.scrolloff = 3

-- New splits are going below and right.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Make backspaces more powerful.
vim.opt.backspace = 'indent,start,eol'

-- Conceal cursor for markdown.
vim.wo.concealcursor = 'nc'
vim.wo.conceallevel = 2

-- Markdown specifics.
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_strikethrough = 1
vim.g.vim_markdown_json_frontmatter = 1

vim.api.nvim_exec(
  [[
  augroup Markdown
    autocmd!
    autocmd FileType markdown setlocal spell
    " autocmd BufNewFile,BufRead *.md setlocal spell
    au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown tw=80 fo+=t
    au BufNewFile,BufFilePre,BufRead *.md set colorcolumn=80
    au BufNewFile,BufFilePre,BufRead *.md set conceallevel=2
    au BufNewFile,BufFilePre,BufRead *.md set ts=2 softtabstop=2 expandtab
    au BufNewFile,BufFilePre,BufRead *.md set nonumber rnu
  augroup end
]],
  false
)

-- Folding with a tree-sitter.
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Color column.
vim.opt.colorcolumn = '79'

-- Give me some fenced codeblock goodness (works by default?).
-- vim.cmd [[
-- let g.markdown_fenced_languages = [ 'html', 'javascript', 'css', 'lua', 'vim', 'python' ]
-- ]]

-- Jump to the last position when reopening a file.
vim.cmd [[
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
endif
]]

-- nvim-terminal setup.
vim.o.hidden = true

require('nvim-terminal').setup({
    window = {
        -- Do `:h :botright` for more information
        -- NOTE: width or height may not be applied in some "pos"
        position = 'botright',

        -- Do `:h split` for more information
        split = 'sp',

        -- Width of the terminal
        width = 50,

        -- Height of the terminal
        height = 15,
    },

    -- keymap to disablesb all the default keymaps
    disable_default_keymaps = false,

    -- keymap to toggle open and close terminal window
    toggle_keymap = '<M-t>',

    -- increase the window width by when you hit the keymap
    window_height_change_amount = 2,

    -- increase the window height by when you hit the keymap
    window_width_change_amount = 2,

    -- keymap to increase the window width
    increase_width_keymap = '<leader><leader>+',

    -- keymap to decrease the window width
    decrease_width_keymap = '<leader><leader>-',

    -- keymap to increase the window height
    increase_height_keymap = '<leader>=',

    -- keymap to decrease the window height
    decrease_height_keymap = '<leader>-',

    terminals = {
        -- keymaps to open nth terminal
        {keymap = '<leader>1'},
        {keymap = '<leader>2'},
        {keymap = '<leader>3'},
        {keymap = '<leader>4'},
        {keymap = '<leader>5'},
    },
})

-- nvim-ts-rainbow setup.
require('nvim-treesitter.configs').setup {
  rainbow = {
    enable = true,
    -- Also highliht non-bracket delimiters like html tags, boolean or table.
    extended_mode = true,
    max_file_lines = nil, -- Do not enable for files with more than n lines
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}

-- nvim-colorizer setup.
-- require('colorizer').setup()
-- require 'colorizer'.setup {
--   css = { rgb_fn = true; RRGGBBAA = true; };
--   'javascript';
--   html = { mode = 'foreground'};
-- }

-- vim-hexokinase setup.
vim.g.Hexokinase_highlighters = {'virtual'}

-- TODO: Do I need: wildmenu, wildmode, nospell, redrawtime?
-- py/md specifics?

-- Set completeopt to have a better completion experience
vim.o.completeopt='menuone,noinsert,noselect'

-- Changed default timeout for key combos from 1000 to 333ms.
vim.opt.timeoutlen = 333

-- New line after comment does not start as a comment line.
vim.o.formatoptions = 'jcql'

-- Easy split-jumps with <leader> key.
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true } -- no recursive mapping
keymap('n', '<leader>j', '<C-w>j', opts)
keymap('n', '<leader>k', '<C-w>k', opts)
keymap('n', '<leader>h', '<C-w>h', opts)
keymap('n', '<leader>l', '<C-w>l', opts)
keymap('n', '<leader>w', '<C-w>w', opts)

-- Escape the terminal!
keymap('t', '<M-t>', '<C-\\><C-n>', opts)

-- Use arrow keys in terminal mode for auto completion.
keymap('t', '<C-k>', '<Up>', {})
keymap('t', '<C-j>', '<Down>', {})
keymap('t', '<C-h>', '<Left>', {})
keymap('t', '<C-l>', '<Right>', {})

-- Use arrow keys in command mode for auto completion.
keymap('c', '<C-K>', '<Up>', {})
keymap('c', '<C-J>', '<Down>', {})
keymap('c', '<C-H>', '<Left>', {})
keymap('c', '<C-L>', '<Right>', {})

-- Mainstream shortcut for save (could help with split keyboard?).
keymap('n', '<C-s>', ':w<CR>', {})
keymap('i', '<C-s>', '<Esc>:w<CR>a', {})

-- Put a new line before or after to current line in normal mode.
-- keymap('n', 'oo', "m'o<Esc>``", opts)
-- keymap('n', 'OO', "m'O<Esc>``", opts)
keymap('n', 'oo', "]<Space>", {})
keymap('n', 'OO', "[<Space>", {})

-- Comment in / out line.
keymap('n', '<leader>/', 'gcc<Esc>', {})
keymap('v', '<leader>/', 'gcc<Esc>', {})

-- Jupyter default bindings are coliding with Telescope's mappings.
keymap('n', '<leader>x', '<C-s><Plug>JupyterExecute', {})
keymap('n', '<leader>X', '<C-s><Plug>JupyterExecuteAll', {})

-- Toggle lsp diagnostics
require'toggle_lsp_diagnostics'.init({{ start_on = false }})
-- require'toggle_lsp_diagnostics'.init()
-- nmap <leader>td <Plug>(toggle-lsp-diag)
keymap('n', '<leader>td',  '<cmd>ToggleDiag<CR>', {})

-- Test LSP highlighting remove underline (change to gray better.
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   -- Enable underline, use default values
   underline = false,
   -- Enable virtual text only on Warning or above, override spacing to 2
   virtual_text = {
     spacing = 2,
     severity_limit = "Warning",
   },
 }
)

-- Styling
-- Catppuccino fine tune
-- local catppuccino = require("catppuccino")

-- configure it
-- catppuccino.setup(
--     {
-- 		colorscheme = "light_melya",
-- 		transparency = false,
-- 		term_colors = false,
-- 		styles = {
-- 			comments = "italic",
-- 			functions = "italic",
-- 			keywords = "italic",
-- 			strings = "NONE",
-- 			variables = "NONE",
-- 		},
-- 		integrations = {
-- 			treesitter = true,
-- 			native_lsp = {
-- 				enabled = true,
-- 				virtual_text = {
-- 					errors = "italic",
-- 					hints = "italic",
-- 					warnings = "italic",
-- 					information = "italic",
-- 				},
-- 				underlines = {
-- 					errors = "underline",
-- 					hints = "underline",
-- 					warnings = "underline",
-- 					information = "underline",
-- 				}
-- 			},
-- 			lsp_trouble = false,
-- 			lsp_saga = false,
-- 			gitgutter = true,
-- 			gitsigns = true,
-- 			telescope = true,
-- 			nvimtree = {
-- 				enabled = true,
-- 				show_root = true,
-- 			},
-- 			which_key = false,
-- 			indent_blankline = {
-- 				enabled = true,
-- 				colored_indent_levels = true,
-- 			},
-- 			dashboard = false,
-- 			neogit = false,
-- 			vim_sneak = false,
-- 			fern = false,
-- 			barbar = false,
-- 			bufferline = false,
-- 			markdown = true,
-- 			lightspeed = false,
-- 			ts_rainbow = true,
-- 			hop = false,
-- 		}
-- 	}
-- )

-- Fine tune colorcode.
-- Load and setup function to choose plugin and language highlights
-- require('lush')(require('codeschool').setup({
--   plugins = {
--     "buftabline",
--     "coc",
--     "fzf",
--     "gitgutter",
--     "gitsigns",
--     "lsp",
--     "lspsaga",
--     "nerdtree",
--     "netrw",
--     "nvimtree",
--     "neogit"
--     "signify",
--     "startify",
--     "syntastic",
--     "telescope",
--     "treesitter"
--   },
--   langs = {
--     "c",
--     "clojure",
--     "coffeescript",
--     "csharp",
--     "css",
--     "elixir",
--     "golang",
--     "haskell",
--     "html",
--     "java",
--     "js",
--     "json",
--     "jsx",
--     "lua",
--     "markdown",
--     "moonscript",
--     "objc",
--     "ocaml",
--     "purescript",
--     "python",
--     "ruby",
--     "rust",
--     "scala",
--     "typescript",
--     "viml",
--     "xml"
--   }
-- }))

-- Fine tune modus theme.
vim.g.modus_yellow_comments = 1
vim.g.modus_green_strings = 1
vim.g.modus_faint_syntax = 1
vim.g.modus_cursorline_intense = 0

-- Fine tune rose-pine.
-- Toggle variant
-- vim.api.nvim_set_keymap('n', '<c-m>', [[<cmd>lua require('rose-pine.functions').toggle_variant()<cr>]], { noremap = true, silent = true })

-- Fine tune everforest.
vim.g.everforest_transparent_background = 0
vim.g.everforest_ui_contrast = 'low'
vim.g.everforest_background = 'hard'
vim.g.everforest_show_eob = 1
-- vim.g.everforest_diagnostic_line_highlight = 1
-- vim.g.everforest_diagnostic_text_highlight = 0
-- vim.g.everforest_diagnostic_virtual_text = 'grey'
-- vim.g.everforest_current_word = 'bold'

-- Fine tune edge.
vim.g.edge_transparent_background = 0

--Set statusbar
vim.g.lightline = {
  colorscheme = 'everforest',
  -- colorscheme = 'one',
  -- colorscheme = 'gruvbox',
  -- colorscheme = 'edge',
  -- colorscheme = 'PaperColor',
  -- colorscheme = 'ayu_light',
  active = { left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } } },
  -- component_function = { gitbranch = 'fugitive#head' },
  component_function = { gitbranch = 'fugitive#Head' },
  -- component_function = { gitbranch = 'FugitiveHead' },
}

vim.o.background = 'light'
vim.cmd [[colorscheme everforest]]
-- vim.cmd [[colorscheme space-nvim]]
-- vim.cmd [[colorscheme edge]]
-- vim.cmd [[colorscheme one-nvim]]
-- vim.cmd [[colorscheme modus-operandi]]

