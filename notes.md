# Transition from vimrc to init.lua


## Basic configuration

Three types of configuration options:

1. Global options (vim.o)
2. Local to window (vim.wo)
3. Local to buffer (vim.bo)

Let's start by converting some basic stuff:

```vim
set expandtab
set shiftwidth=2
set softtabstop=2
```

```lua
vim.bo.expandtab = true
vim.bo.shiftwidth = 2  -- :lua print(vim.bo.shiftwidth)
vim.bo.softtabstop = 2
```


### Keybindings

Set them using
`vim.api.nvim_set_keymap({mode}, {keymap}, {mapped to}, {options})`.

```vim
" Ctrl-s to save.
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a
" Ctrl-hhl to navigate splits.
nnoremap <C-j> <C-w>j
nnoremap <C-h> <C-w>h
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
```

```lua
local keymap = vim.api.nvim_set_keymap
keymap('n', '<C-s>', ':w<CR', {})
keymap('i', '<C-s>', '<Esc>:w<CR>a', {})
local opts = { noremap = true }
keymap('n', '<C-j>', '<C-w>j', opts)  -- etc.
```


### Package management

We're going to use `packer.nvim` and it will manage itself:

```lua
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  -- add other use ... for other packages
end)
```

And than we can run `:PackerSync` which will download/install them.


## Quick fixes, snippets and cheat-sheet

- Booleans:
  * set autoindent ==> vim.opt.autoindent = true

- Strings:
  * set backspace='indent,start,eol' ==> vim.opt.backspace='indent,start,eol' 

- Looks like Boolean but it is Ternary string (yes, no, auto):
  * set backupcopy=yes ==> vim.opt.backupcopy='yes'

- Negation of Boolean:
  * set nobackup ==> vim.opt.backup = false

- Pattern:
  * In vimrc
    ```
    setbackupdir=~/.vim/backup//
    setbackupdir+=.
    ```
  * Is equivalent to: `setbackupdir=foo,bar`
  * Lua needs to expand `~`:
    ```
    vim.opt.backupdir = vim.fn.expand('~/.vim/backup//')
    vim.opt.backupdir = vim.opt.backupdir + '.'
    ```


## Random lua

- Print out some nvim options to the console:
    * `:lua print(vim.opt.backupdir)`
    * `>table: 0x40254fc0` -> lua object that has its methods etc.
    * `:lua print(vim.inspect(vim.opt.backupdir))`
        ```lua
        >{
          _info = {
            allows_duplicates = false,
            commalist = true,
            default = ".,/home/mladen/.local/share/nvim/backup//",
            flaglist = false,
            global_local = false,
            last_set_chan = 0,
            last_set_linenr = 0,
            last_set_sid = 0,
            name = "backupdir",
            scope = "global",
            shortname = "bdir",
            type = "string",
            was_set = false
          },
          _name = "backupdir",
          _value = ".,/home/mladen/.local/share/nvim/backup//",
          <metatable> = <1>{
            __add = <function 1>,
            __index = <table 1>,
            __pow = <function 2>,
            __sub = <function 3>,
            _set = <function 4>,
            append = <function 5>,
            get = <function 6>,
            prepend = <function 7>,
            remove = <function 8>
          }
        }
       ```
    * `:lua print(vim.opt.backupdir.get())`
    * `>table: 0x402482908`
    * `:lua print(vim.inspect(vim.opt.backupdir.get()))`
    * array like table of backup paths


### Setting colorcolumn

```vim
if exists('+colorcolumn')
  " Highlight up to 255 columns (this is the current Vim max) beyond 'textwidth'
  let &l:colorcolumn='+' . join(range(0, 254), ',+')
  " This is equalent to: setlocal color hardcoded_value
endif
```

```lua
-- Calling a vim range fn, better is to do idiomatic lua.
vim.opt_local.colorcolumn = '+' .. vim.fn.join(vim.fn.range(0, 254), ',+')
```


### Setting foldtext

```vim
set foldtext=wincent#settings#foldtext()
```

```lua
-- It is a string not a vim function.
vim.opt.foldtext='wincent#settings#foldtext()'
```


### Am I in vim or vi?

```vim
if v:progname !=# 'vi'
  set softtabstop=-1
endif
```

```lua
if vim.v.progname ~= 'vi' then
  vim.opt.softtabstop=-1
  -- :lua print(vim.o.softtabstop) -> returns only the value (only for reads)
  -- :lua print(vim.opt.softtabstop) -> returns the lua object table (C*UD)
end
```

TODO:

- [x] Restore old vim files and push `init.lua`
  * [x] Update the remote
- [x] Simulate arrows in the terminal mode
- [x] Comment out code with <C-/>
- [o] Map <leader-w> to jump to last buffer
- [ ] Next line does not put comment or indent 4 spaces
- [x] In insert mode <C-l> <Esc>a or <C-space>
- [ ] <M-t> for toggle terminal to do it instantly
- [ ] `netrw` opens with tree like structure w/o help text
- [ ] Remove status line text (-- INSERT --)
- [x] Bindings for spell checking
- [o] MD settings
  * [x] Automatic line break
  * [x] set spell
  * [o] Bind macros for code blocks
  * [ ] What does False means in auto-command?
- [ ] <leader>x to save and execute
- [ ] Delete in the visual mode!!!
- [ ] <C-v> in insert mode <C-o>"+p
- [ ] Delete <C-h>,<C-j> bindings (used widely across the platforms)
  * [ ] Replacement for arrows mappings


# Random

CTRL-W    delete word to the left of cursor
CTRL-O D  delete everything to the right of cursor
CTRL-U    delete everything to the left of cursor
CTRL-H    backspace/delete
CTRL-J    insert newline (easier than reaching for the return key)
CTRL-T    indent current line
CTRL-D    un-indent current line

