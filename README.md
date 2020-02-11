# ale-linter-eastwood

ALE integration for the Purdue CS240 C code linter.

If you don't know what ALE is, this probably isn't for you.

To use this linter, first copy or link the `~cs240/bin/eastwood` executable
somewhere in your path (`~/.local/bin` is a common one).  Then, either install
this repository using your preferred plugin manager or just copy the
`ale_linters` directory into your vim configuration directory (`~/.vim` for
vim, `~/.config/nvim` for neovim).  Finally, make sure to enable the `eastwood`
linter in the ALE options for the `c` filetype (via `g:ale_linters` or whatever
your preferred method is).
