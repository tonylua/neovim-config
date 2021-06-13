## 1. Chrome

### 全屏截图

- 开发者模式，Command+Shift+P

---

## 2. 终端

### Tmux 常用命令

> 先输入命令 tmux，按 Ctrl+b 激活控制台；此时以下按键生效）：

- `?:` 列出所有快捷键；按 Esc 或 q 返回
- `":` 垂直分割当前窗口
- `%:` 水平分割当前窗口
- `!:` 关闭当前子窗口
- `&:` 确认并退出整个窗口
- 方向键：切换子窗口

### 搜索替换

> https://alexharv074.github.io/2019/04/16/a-sed-tutorial-and-reference.html#command-line-options

- mac 下 -i 后面加 ""
- sed -i "s/查找字段/替换字段/gi" `grep 查找字段 -rl 路径`
- grep '正则内容' -rn（或 -rl） src/\*_/_ | sort | uniq
- sed -i 's/查找字段/替换字段/g' `grep "deletable" -rl src/**/* | sort | uniq`
- 排除用 `--exclude`

```
sed -i "" 's/jad-/jadx-/g' `grep "jad-" -rl --exclude="**/*.spec.js" src/components/Cascader/**/*`
```

### 查看占用端口

- `lsof -i:端口号`

### 打包配置

```
zip -vr my_config.zip ~/.config/ -x "*.DS_Store" -x '*node_modules*'
```

### 刷新 dns

- sudo killall -HUP mDNSResponder

### 自动排列“启动台”图标

```
defaults write com.apple.dock ResetLaunchPad -bool true; killall Dock
```

### 逐级查看磁盘占用空间情况

```
sudo du -sh *
...
sudo du -sh ./Movies/DaVinci\ Resolve/CacheClip/*
```

### 删除 DaVinci 缓存

```
rm -rf ~/Movies/DaVinci\ Resolve/CacheClip/*
```

### 刷新 dns

- sudo killall -HUP mDNSResponder
- sudo dscacheutil -flushcache

## 3. NeoVim

### 配置文件

- `~/.config/nvim/init.vim`
- `~/.config/nvim/coc-settings.json`
- 在打开的某个文件中运行 `:echo &filetype` 确定当前文件类型
- 如果更新了配置中支持的文件类型可能需要重新运行 `:CocInstall coc-XXX` 以升级扩展

### 安装插件

```
nvim +PlugInstall

# 安装后重启 nvim，检查安装结果
:checkhealth
```

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

- `Ctrl + N`: 打开终端，多页签切换到终端时需要用 i 和 ESC 切换其输入状态
- `Alt + h\j\k\l`: 在文件树和分割页间切换焦点
- `:res+行数`: 改变分割页的尺寸
- `:vertical resize 列数`: 改变竖向分割页尺寸
- `:quitall`: 多个 tab 时一次性退出 vim

### 文件搜索：

- `Ctrl + P`: 打开搜索页签，搜索并选中目录
- 回车：在当前激活的窗口打开选中目录
- `Ctrl + T`: 在新页签中打开
- `Ctrl + S`: 在上下新分割页中打开
- `Ctrl + V`: 在左右新分割页中打开

```
find **/* -name "element-icons.ttf"
```

### 搜索替换

- `:Ag 文本内容`: 搜索项目内包含文本内容的文件，快捷键同文件搜索
- vim 中的非贪婪模式，不用 ？而是加 \{-}
- 交互式替换: `:%s/old/new/gc` ，y 是 n 跳过 a 所有

### 清除搜索高亮

- `:noh`

### 大小写转化

> 先用 v 选中

- gu
- gU

### 多行插入同样字符

- ctrl+v 进入列选择
- 按大写 I 进入插入模式
- 输入要插入的字符
- 按 Esc 键退出

### 多行行尾插入

- ctrl+v 进入列选择
- 依次输入 G $ A
- 同上

### 修正缩进

- `gg=G`
- 如果要指定缩紧几个空格，先运行 :set shiftwidth=2

### 跳转到指定行

- `ngg`
- `nG` （跳转到文件第 n 行，无需回车）
- `:n` （跳转到文件第 n 行，需要回车）

### 退出 recording 模式

- 在非 insert 状态下按 q 键

### 挪动 split 窗口位置

- Ctrl + w，R 向上/向左
- Ctrl + w，r 向下/向右

### 在两个并排 split 窗口比对 diff

- 用 `:vnew` 新建 split
- 在两个 split 里贴好内容
- 运行 `:windo diffthis` 开启对比 (`diffoff` 可关闭对比)
- 先 ] 后 c 跳转到下一个差异点：`]c` ，反向跳转是：`[c`

### 折叠

- 多行选择后，`zf` / `zd`

### 书签

> https://www.yiibai.com/vim/vim_markers.html

### 处理 git 冲突

> https://www.jianshu.com/p/0541a67c6d3f

```
git config --global merge.tool vimdiff
git config --global mergetool.vimdiff.path nvim
```

- 运行 `git mergetool`
- ctrl + hjkl 在四个窗口可切换
- 聚焦到冲突点，运行 `:diffget RE` 应用远端的更改（还有 `LO` 和 `BA`）
- 要一次性解决整个文件，用 `:%diffget RE`
- 先 ] 后 c 跳转到下一个差异点：`]c` ，反向跳转是：`[c`
- 都改完 `:wqa` 退出自动切到下一个文件

---

## 4. Git

### git clone 加速

- 将 github.com 换为 github.com.cnpmjs.org 即可实现加速

### git 暂存

- git stash
- git stash pop

### 查看某次 commit 并排除文件

```
git show --pretty <hash> -- . ':(exclude)package-lock.json'
git diff --pretty <hash> ':(exclude)package-lock.json' ':(exclude)src/components/**/*'
```

### git 删除 untracked files

- git clean -fd

### 分支改名

- 本地分支重命名 `git branch -m old new`
- 删除远程分支 `git push origin :远程分支名`
- 将本地分支推送到远程分支 `git push origin 本地分支名:远程分支名`

---

## 5. Nginx

### 匹配多个路径

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

### 指定配置文件启动

- nginx -c 绝对路径

### 重启和关闭

- nginx -s reload
- nginx -s stop

### 手动关闭

- ps -ef | grep nginx
- kill -QUIT 主进程（master）号
