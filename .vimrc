" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------
let g:iswindows = 0
let g:islinux = 0
if(has("win32") || has("win64") || has("win95") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

" =============================================================================
"                          << 以下为软件默认配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set diffexpr=MyDiff()

    function MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ '\<cmd'
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if g:islinux
    set hlsearch        "高亮搜索
    set incsearch       "在输入要搜索的文字时，实时匹配

    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    endif

    if g:isGUI
        " Source a global configuration file if available
        if filereadable("/etc/vim/gvimrc.local")
            source /etc/vim/gvimrc.local
        endif
    else
        " This line should not be removed as it ensures that various options are
        " properly set to work with the Vim-related packages available in Debian.
        runtime! debian.vim

        " Vim5 and later versions support syntax highlighting. Uncommenting the next
        " line enables syntax highlighting by default.
        if has("syntax")
            syntax on
        endif

        set mouse=a                    " 在任何模式下启用鼠标
        set t_Co=256                   " 在终端启用256色
        set backspace=2                " 设置退格键可用

        " Source a global configuration file if available
        if filereadable("/etc/vim/vimrc.local")
            source /etc/vim/vimrc.local
        endif
    endif
endif

" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set number                                              "显示行号
" set relativenumber                                    "相对行号
" set laststatus=2                                      "启用状态栏信息
set cmdheight=2                                         "设置命令行的高度为2，默认为1
"set cursorline                                         "突出显示当前行
if g:iswindows
    set guifont=Consolas:h12
    " set guifont=Ubuntu_Mono:h1
else
    set guifont=Ubuntu\ Mono\ 13
endif


"set nowrap                                            "设置不自动换行
set shortmess=atI                                     "去掉欢迎界面
"set gcr=a:block-blinkon0                              "禁止光标闪烁
"set gcr=a:block-blinkon500
set novisualbell                                        " 不要闪烁 
" 设置 gVim 窗口初始位置及大小
if g:isGUI
    au GUIEnter * simalt ~x                           "窗口启动时自动最大化
    winpos 100 10                                     "指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=38 columns=120                          "指定窗口大小，lines为高度，columns为宽度
endif

" 设置代码配色方案
if g:isGUI
    " colorscheme jellybeans
    colorscheme monokai
    set background=dark
else
    " colorscheme jellybeans 
    colorscheme monokai 
    set background=light
endif

" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    map <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
        \set guioptions+=L <Bar>
    \endif<CR>
endif

" -----------------------------------------------------------------------------
"  < 其它配置 >
" -----------------------------------------------------------------------------
set writebackup                             "保存文件前建立备份，保存成功后删除该备份
set nobackup                                "设置无备份文件
set noswapfile                              "设置无临时文件
set noundofile                              "设置无undo文件

" =============================================================================
"                          << 以下为常用工具配置 >>
" =============================================================================

" Quickfix配置
nmap <silent> <C-N> :cn<CR>zv
nmap <silent> <C-P> :cp<CR>zv

" -----------------------------------------------------------------------------
"  < cscope 工具配置 >
" -----------------------------------------------------------------------------
" 用Cscope自己的话说 - "你可以把它当做是超过频的ctags"
if has("cscope")
    " set csprg=gtags-cscope               " 使用gtags-cscope
set csprg=cscope                     " 使用cscope
    set cscopequickfix=s-,c-,d-,i-,t-,e- " 设定可以使用 quickfix 窗口来查看 cscope 结果
    set cscopetag                        " 使支持用 Ctrl+]  和 Ctrl+t 快捷键在代码间跳转
    set csto=0                           " 如果你想反向搜索顺序设置为1
    set cscopeverbose

    " 在当前目录中添加任何数据库
    if filereadable("cscope.out")
        silent! execute "cs add cscope.out"
    elseif $CSCOPE_DB != ""              " 否则添加数据库环境中所指出的
        silent exe "cs add $CSCOPE_DB"
    endif

    " 快捷键设置
    " 0 or s: Find this C symbol
    " 1 or g: Find this definition
    " 2 or d: Find functions called by this function
    " 3 or c: Find functions calling this function
    " 4 or t: Find this text string
" 6 or e: Find this egrep pattern
    " 7 or f: Find this file
    " 8 or i: Find files #including this file
    nmap <leader><leader>gs :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader><leader>gg :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader><leader>gc :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader><leader>gt :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader><leader>ge :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader><leader>gf :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader><leader>gi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <leader><leader>gd :cs find d <C-R>=expand("<cword>")<CR><CR>

    nmap <leader><leader>cs :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader><leader>cg :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader><leader>cc :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader><leader>ct :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader><leader>ce :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader><leader>cf :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader><leader>ci :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <leader><leader>cd :scs find d <C-R>=expand("<cword>")<CR><CR>
endif

func! CscopeBuild()
    if(has('win32'))
        silent! execute "!dir /s /b *.c,*.cpp,*.cc,*.h,*.java,*.cs,*.lua,*.txt,*.py > cscope.files"
    else
        silent! execute "!find . -name \"*.[hcm]\" -o -name \".hpp\" -o -name \"*.cpp\" -o -name \"*.cc\" -o -name \"*.mm\" -o -name \"*.java\" -o -name \"*.py\" -o -name \"*.lua\" > cscope.files"
    endif

    silent! exe "!cscope -Rbkq"
    if filereadable("cscope.out")
        silent! execute "cs kill cscope.out"
        silent! execute "cs add cscope.out"
    endif
endfunc

map <S-C> <Esc>:call CscopeBuild()<CR>

" -----------------------------------------------------------------------------
"  < ctags 工具配置 >
" -----------------------------------------------------------------------------
" 对浏览代码非常的方便,可以在函数,变量之间跳转等
set tags+=tags;                            "向上级目录递归查找tags文件（好像只有在Windows下才有用）
"set tags+=./addtags/qt5_h
"set tags+=./addtags/cpp_stl
"set tags+=./addtags/qt5_cpp

" -----------------------------------------------------------------------------
"  < ccvext.vim 插件配置 >
" -----------------------------------------------------------------------------
" 用于对指定文件自动生成tags与cscope文件并连接
" 如果是Windows系统, 则生成的文件在源文件所在盘符根目录的.symbs目录下(如: X:\.symbs\)
" 如果是Linux系统, 则生成的文件在~/.symbs/目录下
" 具体用法可参考www.vim.org中此插件的说明
" <Leader>sy 自动生成tags与cscope文件并连接
" <Leader>sc 连接已存在的tags与cscope文件

" -----------------------------------------------------------------------------
"  < ctrlp.vim 插件配置 >
" -----------------------------------------------------------------------------
" 一个全路径模糊文件，缓冲区，最近最多使用，... 检索插件；详细帮助见 :h ctrlp
" 常规模式下输入：Ctrl + p 调用插件
" -----------------------------------------------------------------------------
let g:ctrlp_map = '<leader>p'
let g:ctrlp_max_files=0
let g:ctrlp_by_filename = 1
let g:ctrlp_follow_symlinks=1
let g:ctrlp_open_new_file = 't'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
            \ }
" customize the mappings in CtrlP's prompt
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': ['<c-t>'],
  \ 'AcceptSelection("t")': ['<cr>']
  \ }

" =============================================================================
"                     << windows 下解决 Quickfix 乱码问题 >>
" =============================================================================
" windows 默认编码为 cp936，而 Gvim(Vim) 内部编码为 utf-8，所以常常输出为乱码
" 以下代码可以将编码为 cp936 的输出信息转换为 utf-8 编码，以解决输出乱码问题
" 但好像只对输出信息全部为中文才有满意的效果，如果输出信息是中英混合的，那可能
" 不成功，会造成其中一种语言乱码，输出信息全部为英文的好像不会乱码
" 如果输出信息为乱码的可以试一下下面的代码，如果不行就还是给它注释掉

if g:iswindows
    function! QfMakeConv()
        let qflist = getqflist()
        for i in qflist
           let i.text = iconv(i.text, "cp936", "utf-8")
        endfor
        call setqflist(qflist)
     endfunction
     au QuickfixCmdPost make call QfMakeConv()
endif

" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------
" 注：使用utf-8格式后，软件与程序源码、文件路径不能有中文，否则报错
set encoding=utf-8                                    "设置gvim内部编码
set fileencoding=utf-8                                "设置当前文件编码
set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1     "设置支持打开的文件的编码

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新文件的<EOL>格式
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    "source $VIMRUNTIME/delmenu.vim
    "source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif


" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Vundle 插件管理工具配置 >
" -----------------------------------------------------------------------------
set nocompatible                                      "禁用 Vi 兼容模式
filetype off                                          "禁用文件类型侦测

if g:islinux
    "set rtp+=~/vimfiles/bundle/vundle/
    set rtp+=$VIM/vimfiles/bundle/vundle/
    "call vundle#rc()
    call vundle#rc('$VIM/vimfiles/bundle/')
else
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
endif

Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
" Plugin 'mzlogin/vim-markdown-toc' " 用来生成Markdown的toc
Plugin 'winmanager'
Plugin 'ccvext.vim'
Plugin 'majutsushi/tagbar'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'Mark--Karkat'
Plugin 'Lokaltog/vim-powerline'

" -----------------------------------------------------------------------------
"  < Tagbar 插件配置 >
" -----------------------------------------------------------------------------
" 相对 TagList 能更好的支持面向对象

" 常规模式下输入 tb 调用插件，如果有打开 TagList 窗口则先将其关闭
nmap tb :TagbarToggle<CR>

let g:tagbar_left = 0
let g:tagbar_width=25                       "设置窗口宽度
let g:tagbar_autoclose=0                    "自动折叠

" -----------------------------------------------------------------------------
"  < nerdcommenter 插件配置 >
" -----------------------------------------------------------------------------
" 我主要用于C/C++代码注释(其它的也行)
" 以下为插件默认快捷键，其中的说明是以C/C++为例的，其它语言类似
" <Leader>ci 以每行一个 /* */ 注释选中行(选中区域所在行)，再输入则取消注释
" <Leader>cm 以一个 /* */ 注释选中行(选中区域所在行)，再输入则称重复注释
" <Leader>cc 以每行一个 /* */ 注释选中行或区域，再输入则称重复注释
" <Leader>cu 取消选中区域(行)的注释，选中区域(行)内至少有一个 /* */
" <Leader>ca 在/*...*/与//这两种注释方式中切换（其它语言可能不一样了）
" <Leader>cA 行尾注释
let NERDSpaceDelims = 1                     "在左注释符之后，右注释符之前留有空格

" -----------------------------------------------------------------------------
"  < nerdtree 插件配置 >
" -----------------------------------------------------------------------------
" 有目录树结构的文件浏览插件
" NerdTree use <F2>
let NERDTreeWinPos='left'
let NERDTreeWinSize=35
let NERDTreeChDirMode=1

nmap <leader>f :NERDTreeFind<CR>    " reveal file in tree
nmap <leader>tt :NERDTreeToggle<CR> " Toggle NERDTree
""
" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
filetype on                                             "启用文件类型侦测
filetype plugin on                                      "针对不同的文件类型加载对应的插件
filetype plugin indent on                               "启用缩进
set smartindent                                         "启用智能对齐方式
set expandtab                                           "将Tab键转换为空格
set tabstop=4                                           "设置Tab键的宽度
set shiftwidth=4                                        "换行时自动缩进2个空格
set smarttab                                            "指定按一次backspace就删除shiftwidth宽度的空格
let mapleader=";"                                       "设置快捷键前缀

" 设置代码折叠功能
" set foldlevel=100   " 默认不折叠
" set foldenable
" set foldmethod=indent
set foldmethod=syntax
" set foldcolumn=1    " 设置折叠区域宽度
" set nofoldenable    " 启动时关闭折叠代码
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>  " 用空格键来开关折叠

" 当文件在外部被修改，自动更新该文件
set autoread

" 设置系统剪贴板功能
" nmap <c-F4> "+gp
" nmap <c-F4> "+p
" nmap <c-F5> "+y
nmap <leader>v "+gp
nmap <leader>c "+y
nmap <leader>e "+y
" nmap <leader>e :version
