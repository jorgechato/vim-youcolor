" youcolor - a vim colorscheme with a configurable color palette
" Maintainer: Jorge Chato <jorgechato1@gmail.com>
" Version:    0.0.1-pre
" License:    This file is placed under an ISC-style license. See the included
"             LICENSE file for details.

" Standard Colorscheme Boilerplate {{{
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "youcolor"
" }}}

" Utility Functions {{{
" prints a warning message
function! s:Warn(msg)
  echohl WarningMsg
  echomsg "youcolor: " . a:msg
  echohl NONE
endfunction
" ensures the given dictionary only contains rgb hex colors
function! s:CheckPalette(palette)
  for color in values(a:palette)
    if color !~# '^\d\{1,3}$'
      call s:Warn("invalid palette color: " . color)
      return 0
    endif
  endfor
  return 1
endfunction
" Sets the text color, background color, and attributes for the given
" highlight group. The values of a:hlgroup and
" a:attr are directly inserted into a highlight command. Valid values for
" a:fg and a:bg include the empty string (indicating NONE) and the first
" eight items in s:color_indices.
function! s:Style(hlgroup, fg, bg, attr)
  " get terminal color index
  let l:fg_idx = index(s:color_indices, a:fg)
  let l:bg_idx = index(s:color_indices, a:bg)
  let l:ctermfg   = a:fg     == "" ? "NONE" : a:fg
  let l:ctermbg   = a:bg     == "" ? "NONE" : a:bg
  let l:attr    = a:attr   == "" ? "NONE" : a:attr
  " use bright colors with the bold attr
  if a:attr =~# "bold" && (0 <= l:fg_idx && l:fg_idx < 8)
    let l:ctermfg = s:color_indices[l:fg_idx + 8]
  endif

  execute "highlight " . a:hlgroup . " ctermfg=" . l:ctermfg . " ctermbg=" .
    \ l:ctermbg . " cterm=" . l:attr
endfunction
" }}}

" Set Color Palette {{{
" Default cterm colors if background is *light* and no custom palette is used.
" This is the Tango theme from gnome-terminal.
let s:default_light = {
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
" Default cterm colors if background is *dark* and no custom palette is used.
" This is the Tango theme from gnome-terminal.
let s:default_dark = {
  \'text':       '16',
  \'background': '231',
  \'black':      '16',   'dark_grey':      '59',
  \'red':        '160',  'bright_red':     '196',
  \'green':      '64',   'bright_green':   '113',
  \'yellow':     '178',  'bright_yellow':  '221',
  \'blue':       '61',   'bright_blue':    '74',
  \'magenta':    '96',   'bright_magenta': '139',
  \'cyan':       '30',   'bright_cyan':    '80',
  \'white':      '188',  'bright_white':   '231',
  \}
" choose default colors based on background
if &background == "light"
  let s:palette = s:default_light
else
  let s:palette = s:default_dark
endif
" override default colors with custom palette
if exists("g:youcolor_palette")
  if s:CheckPalette(g:youcolor_palette)
    call extend(s:palette, g:youcolor_palette)
  else
    call s:Warn("using default palette instead")
  endif
endif
" Set some convenience variables so that, e.g. s:palette.red can be referred
" to as s:red.
call extend(s:, s:palette)
" used to look up the corresponding terminal color index for a color
let s:color_indices = [
  \s:black, s:red, s:green, s:yellow, s:blue, s:magenta, s:cyan, s:white,
  \s:dark_grey,
  \s:bright_red,
  \s:bright_green,
  \s:bright_yellow,
  \s:bright_blue,
  \s:bright_magenta,
  \s:bright_cyan,
  \s:bright_white,
  \]
" }}}

" Standard Syntax Highlighting Groups {{{
call s:Style("Normal", s:text, s:background, "")
""           HIGHLIGHT GROUP   TEXT       BACKGROUND ATTRIBUTES
call s:Style("Constant",       s:cyan,        "",        "")
call s:Style("Identifier",     "",        "",        "")
call s:Style("Ignore",         "",        "",        "")
call s:Style("Type",           "",        "",        "")
call s:Style("Statement",      "",        "",        "bold")
call s:Style("Comment",        s:green,    "",        "")
call s:Style("Number",         s:magenta,    "",        "")
call s:Style("Function",       s:green,    "",        "bold")
call s:Style("String",         s:red,     "",        "")
call s:Style("Special",        s:magenta, "",        "")
call s:Style("SpecialComment", s:blue,    "",        "")
call s:Style("PreProc",        s:grey, "",        "bold")
call s:Style("Underlined",     "",        "",        "underline")
call s:Style("Error",          s:white,   s:red,     "bold")
call s:Style("Todo",           s:black,   s:yellow,  "")
call s:Style("MatchParen",     "",        s:cyan,    "")
" }}}

" FileType-specific Tweaks {{{
""           HIGHLIGHT GROUP   TEXT       BACKGROUND ATTRIBUTES
call s:Style("javaStorageClass","",       "",        "bold")
call s:Style("javascriptFunction",   "",  "",        "bold")
call s:Style("javascriptIdentifier", "",  "",        "bold")
call s:Style("luaFunction",    "",        "",        "bold")
call s:Style("phpDefine",      "",        "",        "bold")
call s:Style("rubyDefine",     "",        "",        "bold")
call s:Style("pythonFunction",     s:blue,        "",        "bold")
" this might be a bit too invasive, but for some reason phpVarSelector doesn't
" respond to normal styling
highlight link phpVarSelector phpIdentifier
" }}}

" Vim UI Highlight Groups {{{
""           HIGHLIGHT GROUP   TEXT       BACKGROUND ATTRIBUTES
call s:Style("NonText",        s:black,    s:lightgrey,           "")
call s:Style("Statement",      s:black,    "",           "bold")
call s:Style("SpecialKey",     s:cyan,    "",           "")
call s:Style("LineNr",         s:black,    "",           "bold")
call s:Style("CursorLineNr",   s:red,    "",           "bold")
call s:Style("ErrorMsg",       s:white,   s:red,        "bold")
call s:Style("MoreMsg",        s:cyan,    "",           "")
call s:Style("ModeMsg",        "",        "",           "bold")
call s:Style("Question",       s:cyan,    "",           "")
call s:Style("Title",          s:magenta, "",           "")
call s:Style("WarningMsg",     s:red,     "",           "")
call s:Style("Cursor",         s:text,    s:background, "reverse")
call s:Style("lCursor",        s:text,    s:background, "reverse")
call s:Style("Visual",         "",        "",           "reverse")
call s:Style("VisualNOS",      "",        "",           "bold,underline")
call s:Style("TabLine",        "",        "",           "")
call s:Style("TabLineSel",     s:cyan,    "",           "")
call s:Style("TabLineFill",    "",        "",           "")
call s:Style("ColorColumn",    "",        s:lightgrey,        "")
call s:Style("CursorColumn",   "",        "",           "reverse")
call s:Style("CursorLine",     "",        "",           "underline")
call s:Style("VertSplit",      "",        "",           "reverse")
call s:Style("StatusLine",     "",        "",           "reverse,bold")
call s:Style("StatusLineNC",   "",        "",           "reverse")
call s:Style("WildMenu",       s:white,   s:magenta,    "bold")
call s:Style("Search",         s:black,   "",     "")
call s:Style("IncSearch",      s:black,   s:cyan,       "")
call s:Style("Directory",      s:blue,    "",           "bold")
call s:Style("DiffAdd",        s:green,   "",           "")
call s:Style("DiffDelete",     s:red,     "",           "bold")
call s:Style("DiffChange",     s:magenta, "",           "")
call s:Style("DiffText",       s:magenta, "",           "bold")
call s:Style("Folded",         s:cyan,    "",           "")
call s:Style("FoldColumn",     s:black,    "",           "bold")
call s:Style("SignColumn",     s:black,    "",           "")
call s:Style("Pmenu",          s:white,   s:magenta,    "")
call s:Style("PmenuSel",       "",        "",           "reverse")
call s:Style("PmenuSbar",      "",        s:white,      "")
call s:Style("PmenuThumb",     "",        s:black,      "")
call s:Style("SpellBad",       "",        s:red,        "")
call s:Style("SpellCap",       "",        s:green,      "")
call s:Style("SpellRare",      "",        s:green,      "")
call s:Style("SpellLocal",     "",        s:green,      "")
" Purposefully left unset: Conceal
" }}}
