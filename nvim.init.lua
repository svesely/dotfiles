-- Set leader key to Space
vim.g.mapleader = ' '

-- Status line configuration
vim.opt.laststatus = 2
-- Note: For statusline, you might want to use a Lua-based plugin like lualine instead

-- GUI settings (for GUI frontends like neovim-qt)
if vim.fn.has('gui_running') == 1 then
  vim.opt.guifont = 'Inconsolata:h18'
end

-- disable mouse
vim.opt.mouse = ""

-- Basic settings
vim.opt.number = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- Search settings
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Directory settings
vim.opt.backupdir = vim.fn.expand('~/.local/share/nvim/backup//')
vim.opt.directory = vim.fn.expand('~/.local/share/nvim/swap//')

-- Additional configuration path
vim.g.MYVIMRCAFTER = '~/.config/nvim/init.lua'

-- Key mappings
vim.keymap.set('n', '<leader>w', '<C-W>')
vim.keymap.set('n', '<leader>r', ':TestFile<CR>')
vim.keymap.set('n', '<leader>R', ':TestNearest<CR>')
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', '<leader>fed', ':e ' .. vim.g.MYVIMRCAFTER .. '<CR>')
vim.keymap.set('n', '<leader>fer', ':source ' .. vim.g.MYVIMRCAFTER .. '<CR>')
vim.keymap.set('n', '<C-v>', '"+gP<CR>')
vim.keymap.set('n', '<Leader>pb', ':BuffergatorToggle<CR>')
vim.keymap.set('n', '<leader>pt', ':NERDTreeFind<CR>')
vim.keymap.set('n', '<Leader>bg', function()
  if vim.opt.background:get() == 'dark' then
    vim.opt.background = 'light'
  else
    vim.opt.background = 'dark'
  end
end)
vim.keymap.set('n', '<leader>u', ':UndotreeToggle<CR>')
vim.keymap.set('n', '<leader>n', ':set number!<CR>')
vim.keymap.set('n', '<leader>/', ':Commentary<CR>')
vim.keymap.set('v', '<leader>/', ':Commentary<CR>')

-- More settings
vim.opt.hidden = true
vim.opt.background = 'dark'
vim.opt.wildignore:append('*/tmp/*,*.so,*.swp,*.zip,*/.git/*')
vim.opt.wrap = false

-- Map shortcuts
vim.keymap.set('n', '<m-p>', ':cp<CR>')
vim.keymap.set('n', '<m-n>', ':cn<CR>')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')

vim.keymap.set('n', '<Leader>pf', ':FZF<CR>')

-- Plugin settings
vim.g['airline_section_b'] = ''
vim.g['airline#extensions#tabline#enabled'] = 0
vim.g.ackprg = 'rg --vimgrep'
vim.opt.grepprg = 'rg --vimgrep'

-- Autocommands using Lua API
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end
})

-- Custom mapping
vim.keymap.set('n', '<leader>h', ':s/:\\([^ ]*\\)\\(\\s*\\)=>/\\1:/g<CR>')

-- Bell settings
vim.opt.errorbells = false
vim.opt.visualbell = false
-- vim.opt.t_vb = ''

-- Cursor shape settings
vim.opt.guicursor = 'n-v-c:block-Cursor/lCursor-blinkon1,i-ci:ver25-Cursor/lCursor-blinkon1,r-cr:hor20-Cursor/lCursor-blinkon1'


-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.local/share/nvim/undo')
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- Pencil plugin configuration
vim.g['pencil#wrapModeDefault'] = 'soft'

-- Pencil autocommands
local pencil_group = vim.api.nvim_create_augroup('pencil', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'markdown', 'mkd'},
  group = pencil_group,
  command = 'call pencil#init()'
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'text',
  group = pencil_group,
  command = 'call pencil#init()'
})

vim.api.nvim_create_augroup('filetype_wrap', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = 'filetype_wrap',
  pattern = { 'markdown', 'fountain' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
  end
})

-- Commands
vim.api.nvim_create_user_command('Gblame', 'Git blame', {})

-- EasyAlign configuration
-- Start interactive EasyAlign in visual mode
vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)')
-- Start interactive EasyAlign for a motion/text object
vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- theme/color schemes
    { 'dracula/vim', name = 'dracula'},
    { 'vimwiki/vimwiki', lazy = false },

-- -- Vimwiki
-- vim.keymap.set('n', '<leader>cc', '<Plug>VimwikiToggleListItem')
-- vim.g.vimwiki_list = {{
--   path = '~/vimwiki/',
--   syntax = 'markdown',
--   ext = '.md'
-- }}

-- -- Autocommands for vimwiki
-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--   pattern = "*/vimwiki/*",
--   command = "set filetype=vimwiki"
-- })

    -- editor enhancements
    'editorconfig/editorconfig-vim',
    'mg979/vim-visual-multi',
    'tpope/vim-eunuch',
    'tpope/vim-commentary',
    'tpope/vim-abolish',
    'ervandew/supertab',
    'easymotion/vim-easymotion',
    'junegunn/vim-easy-align',
    'reedes/vim-pencil',

    -- colorful markdown preview mainly for CodeCompanion
    {
      "OXY2DEV/markview.nvim",
      lazy = false,
      opts = {
        preview = {
          filetypes = { "markdown", "codecompanion" },
          ignore_buftypes = {},
        },
      },
    },

    -- navigation and file management
    'preservim/nerdtree',
    'xuyuanp/nerdtree-git-plugin',
    'junegunn/fzf',
    'vim-crystal/vim-crystal',
    'jeetsukumaran/vim-buffergator',
    'mbbill/undotree',

    -- git integration
    'airblade/vim-gitgutter',
    'tpope/vim-fugitive',

    -- code completion and language support
    {'neoclide/coc.nvim', branch = 'release'},

    -- {'fatih/vim-go', build = ':goupdatebinaries'},

    -- language specific plugins
    'rodjek/vim-puppet',
    'stevearc/vim-arduino',

    -- search
    'mileszs/ack.vim',

    -- status line
    'vim-airline/vim-airline',
    "00msjr/nvim-fountain",
    ft = "fountain",  -- Lazy-load only for fountain files
    config = function()
      require("nvim-fountain").setup({
        -- Optional configuration
        keymaps = {
          next_scene = "]]",
          prev_scene = "[[",
          uppercase_line = "<S-CR>",
        },
        -- Export configuration
        export = {
          pdf = { options = "--overwrite --font Courier" },
        },
      })
    end,

  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Plugin Specific Settings

-- NERDTree settings
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeQuitOnOpen = 1

-- GitGutter settings
vim.g.gitgutter_max_signs = 500

-- Coc.nvim recommended settings
vim.opt.updatetime = 300
vim.opt.signcolumn = 'yes'
-- Use tab for trigger completion with coc.nvim
local keyset = vim.keymap.set
function _G.check_back_space()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- GoTo code navigation for coc.nvim
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- FZF settings
vim.env.FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'

-- Ack.vim settings
if vim.fn.executable('rg') == 1 then
  vim.g.ackprg = 'rg --vimgrep --no-heading'
end

-- Treesitter setup
-- Setup Tree-sitter
local ok, treesitter = pcall(require, "nvim-treesitter.configs")
if ok then
  treesitter.setup({
    ensure_installed = { "lua", "markdown", "markdown_inline", "yaml" },
    highlight = { enable = true },
  })
end

vim.keymap.set('n', '<leader>ccc', ':CodeCompanionChat<CR>')

-- Set colorscheme
vim.cmd 'colorscheme dracula'
