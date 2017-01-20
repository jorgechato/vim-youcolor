# Youcolor

Vim-youcolor is a low-key vim colorscheme with an adjustable color palette for cterm color set, which
allows you to easily match it with your terminal's theme.
It is based on [sprinkles](https://github.com/ajgrf/sprinkles). I strongly recommend to check that project out.

## Installation

Vim-youcolor can be installed in the same way as most other vim plugins and
colorscheme. If you don't know how to install vim plugins, I recommend
installing youcolor using Vundle.

```vim
Plugin 'orggue/vim-youcolor'
```

## Configuration

You can define a custom color palette for youcolor to use, with the caveats
described above. Just define the variable `g:youcolor_palette` in your vimrc:

```vim
let g:youcolor_palette = {
\'text':       '16',
\'background': '231',
\'black':      '16',   'dark_grey':      '16',
\'red':        '160',  'bright_red':     '196',
\'green':      '28',   'bright_green':   '28',
\'yellow':     '178',  'bright_yellow':  '221',
\'blue':       '31',   'bright_blue':    '24',
\'magenta':    '161',   'bright_magenta': '139',
\'cyan':       '30',   'bright_cyan':    '80',
\'white':      '188',  'bright_white':   '231',
\'grey':			 '244',	 'bright_grey':    '244',
\'lightgrey':			 '253',
\}
colorscheme youcolor
```
