set background=dark
highlight clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "invader"

" cterm options bold, underline, reverse, italic, none

" UI
hi StatusLine     cterm=none      ctermfg=black       ctermbg=cyan
hi StatusLineNC   cterm=underline ctermfg=darkcyan    ctermbg=none
hi VertSplit      cterm=none      ctermfg=cyan        ctermbg=none
hi LineNr         cterm=none      ctermfg=darkcyan    ctermbg=none
hi CursorLineNr   cterm=none      ctermfg=magenta     ctermbg=none
hi ColorColumn    cterm=none      ctermfg=none        ctermbg=magenta
hi Visual         cterm=reverse   ctermfg=cyan        ctermbg=black

" Syntax
hi Comment        cterm=none      ctermfg=darkcyan    ctermbg=none
hi Constant       cterm=none      ctermfg=cyan        ctermbg=none
hi Identifier     cterm=none      ctermfg=darkgreen   ctermbg=none
hi Statement      cterm=none      ctermfg=darkgreen   ctermbg=none
hi PreProc        cterm=none      ctermfg=blue        ctermbg=none
hi Type           cterm=none      ctermfg=darkyellow  ctermbg=none
hi Special        cterm=none      ctermfg=magenta     ctermbg=none
hi Error          cterm=none      ctermfg=red         ctermbg=none
hi Todo           cterm=underline ctermfg=darkmagenta ctermbg=none

" Highlightning
hi DiffAdd        cterm=none      ctermfg=black       ctermbg=green
hi DiffChange     cterm=none      ctermfg=black       ctermbg=yellow
hi DiffDelete     cterm=none      ctermfg=black       ctermbg=red
hi DiffText       cterm=none      ctermfg=black       ctermbg=blue
hi IncSearch      cterm=none      ctermfg=black        ctermbg=yellow



" Cleared
hi Underlined     cterm=none      ctermfg=none        ctermbg=none
hi Ignore         cterm=none      ctermfg=none        ctermbg=none
hi MatchParen     cterm=none      ctermfg=none        ctermbg=none
hi Conceal        cterm=none      ctermfg=none        ctermbg=none
hi Cursor         cterm=none      ctermfg=none        ctermbg=none
hi CursorIM       cterm=none      ctermfg=none        ctermbg=none
hi CursorColumn   cterm=none      ctermfg=none        ctermbg=none
hi CursorLine     cterm=none      ctermfg=none        ctermbg=none
hi Directory      cterm=none      ctermfg=none        ctermbg=none
hi ErrorMsg       cterm=none      ctermfg=none        ctermbg=none
hi Folded         cterm=none      ctermfg=none        ctermbg=none
hi FoldColumn     cterm=none      ctermfg=none        ctermbg=none
hi SignColumn     cterm=none      ctermfg=none        ctermbg=none
hi MatchParen     cterm=none      ctermfg=none        ctermbg=none
hi ModeMsg        cterm=none      ctermfg=none        ctermbg=none
hi MoreMsg        cterm=none      ctermfg=none        ctermbg=none
hi NonText        cterm=none      ctermfg=none        ctermbg=none
hi Normal         cterm=none      ctermfg=none        ctermbg=none
hi Pmenu          cterm=none      ctermfg=none        ctermbg=none
hi PmenuSel       cterm=none      ctermfg=none        ctermbg=none
hi PmenuSbar      cterm=none      ctermfg=none        ctermbg=none
hi PmenuThumb     cterm=none      ctermfg=none        ctermbg=none
hi Question       cterm=none      ctermfg=none        ctermbg=none
hi Search         cterm=none      ctermfg=none        ctermbg=none
hi SpecialKey     cterm=none      ctermfg=none        ctermbg=none
hi SpellBad       cterm=none      ctermfg=none        ctermbg=none
hi SpellCap       cterm=none      ctermfg=none        ctermbg=none
hi SpellLocal     cterm=none      ctermfg=none        ctermbg=none
hi SpellRare      cterm=none      ctermfg=none        ctermbg=none
hi TabLine        cterm=none      ctermfg=none        ctermbg=none
hi TabLineFill    cterm=none      ctermfg=none        ctermbg=none
hi TabLineSel     cterm=none      ctermfg=none        ctermbg=none
hi Title          cterm=none      ctermfg=none        ctermbg=none
hi VisualNOS      cterm=none      ctermfg=none        ctermbg=none
hi WarningMsg     cterm=none      ctermfg=none        ctermbg=none
hi WildMenu       cterm=none      ctermfg=none        ctermbg=none
