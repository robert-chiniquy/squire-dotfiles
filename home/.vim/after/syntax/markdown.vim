" Markdown syntax highlighting using aesthetic palette
" Palette from ~/.claude/AESTHETIC.md:
"   Background:       #000000
"   Foreground:       #f0f0f0
"   Primary accent:   #ff00f8 (active/important)
"   Secondary accent: #5cecff (links, functions)
"   Tertiary accent:  #fbb725 (strings, paths)
"   Muted:            #aa00e8 (line numbers, secondary)
"   Success:          #58e8a3 (added, good)
"   Error:            #ff6b9d (removed, bad)
"   Selection:        #4e4e8f

" Headings - primary accent, bold
hi markdownH1 guifg=#ff00f8 gui=bold ctermfg=201 cterm=bold
hi markdownH2 guifg=#ff00f8 gui=bold ctermfg=201 cterm=bold
hi markdownH3 guifg=#ff00f8 ctermfg=201
hi markdownH4 guifg=#ff00f8 ctermfg=201
hi markdownH5 guifg=#ff00f8 ctermfg=201
hi markdownH6 guifg=#ff00f8 ctermfg=201
hi markdownHeadingDelimiter guifg=#aa00e8 ctermfg=129

" Links - secondary accent (that's what links are for)
hi markdownUrl guifg=#5cecff ctermfg=87
hi markdownUrlTitle guifg=#5cecff gui=italic ctermfg=87
hi markdownUrlDelimiter guifg=#aa00e8 ctermfg=129
hi markdownUrlTitleDelimiter guifg=#aa00e8 ctermfg=129
hi markdownLinkText guifg=#5cecff gui=underline ctermfg=87 cterm=underline
hi markdownLinkDelimiter guifg=#aa00e8 ctermfg=129

" Code - tertiary accent (strings/paths vibe)
hi markdownCode guifg=#fbb725 ctermfg=214
hi markdownCodeBlock guifg=#fbb725 ctermfg=214
hi markdownCodeDelimiter guifg=#aa00e8 ctermfg=129

" Bold/Italic - foreground with formatting
hi markdownBold guifg=#f0f0f0 gui=bold ctermfg=255 cterm=bold
hi markdownItalic guifg=#f0f0f0 gui=italic ctermfg=255 cterm=italic
hi markdownBoldItalic guifg=#f0f0f0 gui=bold,italic ctermfg=255 cterm=bold,italic
hi markdownBoldDelimiter guifg=#aa00e8 ctermfg=129
hi markdownItalicDelimiter guifg=#aa00e8 ctermfg=129

" List markers - muted
hi markdownListMarker guifg=#aa00e8 ctermfg=129
hi markdownOrderedListMarker guifg=#aa00e8 ctermfg=129

" Blockquotes - muted italic
hi markdownBlockquote guifg=#aa00e8 gui=italic ctermfg=129

" Horizontal rules
hi markdownRule guifg=#aa00e8 ctermfg=129

" ID/references - secondary accent
hi markdownId guifg=#5cecff ctermfg=87
hi markdownIdDeclaration guifg=#5cecff ctermfg=87

" Strikethrough - error color
hi markdownStrike guifg=#ff6b9d gui=strikethrough ctermfg=204

" Valid/error patterns if they exist
hi markdownValid guifg=#58e8a3 ctermfg=85
hi markdownError guifg=#ff6b9d ctermfg=204
