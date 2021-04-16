## chrome全屏截图

开发者模式，Command+Shift+P

## tmux

常用命令（先输入命令tmux，按 Ctrl+b 激活控制台；此时以下按键生效）：

?: 列出所有快捷键；按 Esc 或 q 返回
": 垂直分割当前窗口
%: 水平分割当前窗口
!: 关闭当前子窗口
&: 确认并退出整个窗口
方向键：切换子窗口

## neovim配置文件 


- `~/.config/nvim/init.vim`
- `~/.config/nvim/coc-settings.json`
- 在打开的某个文件中运行 `:echo &filetype` 确定当前文件类型
- 如果更新了配置中支持的文件类型可能需要重新运行 `:CocInstall coc-XXX` 以升级扩展

## neovim安装插件：

```
nvim +PlugInstall

# 安装后重启 nvim，检查安装结果
:checkhealth
```

## 常用快捷键

### 目录树：

- `Ctrl + B`: 打开关闭文件树
- `o`: 在文件树中，上下选择文件后打开
- `go`: 同上，但焦点留在文件树
- `t`: 在新页签中打开
- `T`: 同上，但焦点留在文件树
- `g + t`: 到下一个页签
- `g + T`: 到上一个页签
- `i`: 在上下分割页中打开
- `gi`: 同上，但焦点留在文件树
- `s`: 在左右分割页中打开
- `gs`: 同上，但焦点留在文件树

### 分割页切换和集成终端：

- `Ctrl + N`: 打开终端，多页签切换到终端时需要用i和ESC切换其输入状态
- `Alt + h\j\k\l`: 在文件树和分割页间切换焦点
- `:res+行数`: 改变分割页的尺寸
- `:vertical resize 列数`: 改变竖向分割页尺寸
- `:quitall`: 多个tab时一次性退出vim

### 文件搜索：

- `Ctrl + P`: 打开搜索页签，搜索并选中目录
- 回车：在当前激活的窗口打开选中目录
- `Ctrl + T`: 在新页签中打开
- `Ctrl + S`: 在上下新分割页中打开
- `Ctrl + V`: 在左右新分割页中打开

```
find **/* -name "element-icons.ttf"
```

### 内容搜索替换

- `:Ag 文本内容`: 搜索项目内包含文本内容的文件，快捷键同文件搜索
- vim 中的非贪婪模式，不用 ？而是加 \{-}

#### 终端下 

> https://alexharv074.github.io/2019/04/16/a-sed-tutorial-and-reference.html#command-line-options

- mac 下 -i 后面加 ""
- sed -i "s/查找字段/替换字段/gi" `grep 查找字段 -rl 路径`
- grep '正则内容' -rn（或 -rl） src/**/* | sort | uniq
- sed -i 's/查找字段/替换字段/g' `grep "deletable" -rl src/**/* | sort | uniq`
- 排除用 `--exclude`

```
sed -i "" 's/jad-/jadx-/g' `grep "jad-" -rl --exclude="**/*.spec.js" src/components/Cascader/**/*`
```

### 清除搜索高亮
- :noh

### 大小写转化

- gu
- gU

### 交互式替换

- :%s/old/new/gc ，y 是 n 跳过 a 所有

### 多行插入同样字符

- ctrl+v进入列选择
- 按大写I进入插入模式
- 输入要插入的字符
- 按Esc键退出

### 多行行尾插入

- ctrl+v进入列选择
- 依次输入 G $ A
- 同上

### 修正缩进

- `gg=G`
- 如果要指定缩紧几个空格，先运行 :set shiftwidth=2

### 跳转到指定行

1、ngg/nG （跳转到文件第n行，无需回车）
2、:n （跳转到文件第n行，需要回车）

### 退出recording模式

- 在非insert状态下按q键

### 挪动 split 窗口位置

- Ctrl + w，R 向上/向左
- Ctrl + w，r 向下/向右

### 在两个并排split窗口比对diff

- 用 :vnew 新建split
- 在两个split里贴好内容
- 运行 :windo diffthis 开启对比 (diffoff 可关闭对比)
- 先 ] 后 c 跳转到下一个差异点：]c ，反向跳转是：[ c

### 折叠

- 多行选择后，zf/zd

### 书签
https://www.yiibai.com/vim/vim_markers.html

### git clone 加速

将github.com 换为github.com.cnpmjs.org即可实现加速

### git 暂存

- git stash
- git stash pop

### 查看某次commit并排除文件

```
git show --pretty <hash> -- . ':(exclude)package-lock.json'
git diff --pretty <hash> ':(exclude)package-lock.json' ':(exclude)src/components/**/*'
```

### 查看占用端口

lsof -i:端口号

# 用 nvim 处理 git 冲突

https://www.jianshu.com/p/0541a67c6d3f

```
git config --global merge.tool vimdiff
git config --global mergetool.vimdiff.path nvim
```

- 运行 git mergetool
- ctrl + hjkl 在四个窗口可切换
- 聚焦到冲突点，运行 :diffget RE 应用远端的更改（还有 LO 和 BA）
- 要一次性解决整个文件，用 :%diffget RE
- 先 ] 后 c 跳转到下一个差异点：]c ，反向跳转是：[ c
- 都改完 :wqa 退出自动切到下一个文件

---


![The four directions in Vim, keys h, j, k, and l.](http://vimsheet.com/images/hjkl.png)

*   `w` \- jump by start of words (punctuation considered words)
*   `W` \- jump by words (spaces separate words)
*   `e` \- jump to end of words (punctuation considered words)
*   `E` \- jump to end of words (no punctuation)
*   `b` \- jump backward by words (punctuation considered words)
*   `B` \- jump backward by words (no punctuation)
*   `0` \- (zero) start of line
*   `^` \- first non\-blank character of line (same as 0w)
*   `$` \- end of line
*   Advanced (in order of what I find most useful)
    *   `Ctrl+d` \- move down half a page
    *   `Ctrl+u` \- move up half a page
    *   `}` \- go forward by paragraph (the next blank line)
    *   `{` \- go backward by paragraph (the next blank line)
    *   `gg` \- go to the top of the page
    *   `G` \- go the bottom of the page
    *   `: [num] [enter]` \- Go to that line in the document
    *   Searching
        *   `f [char]` \- Move to the next char on the current line after the cursor
        *   `F [char]` \- Move to the next char on the current line before the cursor
        *   `t [char]` \- Move to before the next char on the current line after the cursor
        *   `T [char]` \- Move to before the next char on the current line before the cursor
        *   All these commands can be followed by `;` (semicolon) to go to the next searched item, and `,` (comma) to go the previous searched item

## Insert/Appending/Editing Text

*   Results in Insert mode
    *   `i` \- start insert mode at cursor
    *   `I` \- insert at the beginning of the line
    *   `a` \- append after the cursor
    *   `A` \- append at the end of the line
    *   `o` \- open (append) blank line below current line (no need to press return)
    *   `O` \- open blank line above current line
    *   `cc` \- change (replace) an entire line
    *   `c [movement command]` \- change (replace) from the cursor to the move\-to point.
    *   ex. `ce` changes from the cursor to the end of the cursor word
*   `Esc` or `Ctrl+[` \- exit insert mode
*   `r [char]` \- replace a single character with the specified char (does not use Insert mode)
*   `d` \- delete
    *   `d` \- \[movement command\] deletes from the cursor to the move\-to point.
    *   ex. `de` deletes from the cursor to the end of the current word
*   `dd` \- delete the current line
*   Advanced
    *   `J` \- join line below to the current one

## Marking text (visual mode)

*   `v` \- starts visual mode
    *   From here you can move around as in normal mode (`h`, `j`, `k`, `l` etc.) and can then do a command (such as `y`, `d`, or `c`)
*   `V` \- starts linewise visual mode
*   `Ctrl+v` \- start visual block mode
*   `Esc` or `Ctrl+[` \- exit visual mode
*   Advanced
    *   `O` \- move to other corner of block
    *   `o` \- move to other end of marked area

## Visual commands

Type any of these while some text is selected to apply the action

*   `y` \- yank (copy) marked text
*   `d` \- delete marked text
*   `c` \- delete the marked text and go into insert mode (like c does above)

## Cut and Paste

*   `yy` \- yank (copy) a line
*   `p` \- put (paste) the clipboard after cursor
*   `P` \- put (paste) before cursor
*   `dd` \- delete (cut) a line
*   `x` \- delete (cut) current character
*   `X` \- delete previous character (like backspace)

## Exiting

*   `:w` \- write (save) the file, but don’t exit
*   `:wq` \- write (save) and quit
*   `:q` \- quit (fails if anything has changed)
*   `:q!` \- quit and throw away changes
*   `:wqa` \- Write and quit all open tabs

## Search/Replace

*   `/pattern` \- search for pattern
*   `?pattern` \- search backward for pattern
*   `n` \- repeat search in same direction
*   `N` \- repeat search in opposite direction
*   `:%s/old/new/g` \- replace all old with new throughout file ([gn](http://vimcasts.org/episodes/operating-on-search-matches-using-gn/) is better though)
*   `:%s/old/new/gc` \- replace all old with new throughout file with confirmations

## Working with multiple files

*   `:e filename` \- Edit a file
*   `:tabe` \- Make a new tab
*   `gt` \- Go to the next tab
*   `gT` \- Go to the previous tab
*   Advanced
    *   `:vsp` \- vertically split windows
    *   `ctrl+ws` \- Split windows horizontally
    *   `ctrl+wv` \- Split windows vertically
    *   `ctrl+ww` \- switch between windows
    *   `ctrl+wq` \- Quit a window

## Marks

Marks allow you to jump to designated points in your code.

*   `m{a-z}` \- Set mark {a\-z} at cursor position
*   A capital mark {A\-Z} sets a global mark and will work between files
*   `‘{a-z}` \- move the cursor to the start of the line where the mark was set
*   `‘’` \- go back to the previous jump location

## General

*   `u` \- undo
*   `Ctrl+r` \- redo
*   `.` \- repeat last command


# 打包配置

```
zip -vr my_config.zip ~/.config/ -x "*.DS_Store" -x '*node_modules*'
```

# nginx

## 匹配多个路径

```
#匹配/node /info /search
 location ~* ^/(node|info|search)/ {
     proxy_pass   http://localhost:8080;
 }

 #绝对匹配一个路径 /info    
 #location ^~ /info/ {
 #    proxy_pass   http://localhost:8080;
 #}
```

## 指定配置文件启动

- nginx -c 绝对路径

## 重启和关闭

- nginx -s reload
- nginx -s stop

## 手动关闭

- ps -ef | grep nginx
- kill -QUIT 主进程（master）号



