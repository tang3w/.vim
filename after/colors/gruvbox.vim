if &background == 'dark'
    hi! SneakPluginTarget     ctermfg=45   ctermbg=NONE cterm=underline guifg=#00d7ff guibg=NONE gui=underline
    hi! SneakStreakTarget     ctermfg=45   ctermbg=NONE cterm=underline guifg=#00d7ff guibg=NONE gui=underline
    hi! SneakStreakMask       ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE    guibg=NONE gui=underline
    hi! link SneakStreakStatusLine StatusLine
else
    hi! SneakPluginTarget     ctermfg=199  ctermbg=NONE cterm=underline guifg=#ff00af guibg=NONE gui=underline
    hi! SneakStreakTarget     ctermfg=199  ctermbg=NONE cterm=underline guifg=#ff00af guibg=NONE gui=underline
    hi! SneakStreakMask       ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE    guibg=NONE gui=underline
    hi! link SneakStreakStatusLine StatusLine
endif
