## 1. Chrome

### 全屏截图

- 开发者模式，Command+Shift+P

### 正则过滤请求

```
regexp:jd\.com\/(?!authadmin)
```

---

## 2. 终端

#### 调出 emoji 表情选择

- control + command + space

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
- 排除用 `--exclude` 或 `--exclude-dir`

```
sed -i "" 's/jad-/jadx-/g' `grep "jad-" -rl --exclude="**/*.spec.js" src/components/Cascader/**/*`
grep "-123px" -rn src/**/* --exclude 'src/assets/common2.0'
```

### 排除某些文件后删除

- find src/views/Reports/create/\* -type 'f' | grep -v 'index.vue' | xargs rm
- find . -type 'd' | grep -v "NameToExclude" | xargs rmdir

### 统计文件个数

- ls -l dir/\*.js | wc -l

### 统计文件体积

- du -hc dist/custom-report/assets/js/\*.js
- c 可读
- h 总数,不带的话结果除 2

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

### 禁用 chrome 前后翻页手势

[firefox](https://support.mozilla.org/en-US/questions/1003526)

```
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool FALSE
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

### 命令行光标移动

要移动到当前行的开头，使用 [Ctrl][a]
要移动到当前行的结尾，使用 [Ctrl][e]
要在当前行从光标位置向前移动一个单词，使用 [Alt][f] 或 [Option][←]
要在当前行从光标位置向前移动一个单词，使用 [Alt][b] 或 [Option][→]

使用 [Ctrl][k] 可以清除光标之后当前行中的字符
[Ctrl][u] 在 bash 和 zsh 则有所区别，前者会清除光标之前的字符，而后者则会清除整行
要清除光标之前的一个单词，使用 [Ctrl][w]
要撤销之前的若干次 [Ctrl][w]，使用 [Ctrl][y]

### 在 Mac 上输入中文标点符号和特殊字符

- Option-Shift-B

---

## 3. NeoVim

### 配置文件

> https://github.com/tonylua/neovim-config

- `~/.config/nvim/init.vim`
- `~/.config/nvim/coc-settings.json`
- 在打开的某个文件中运行 `:echo &filetype` 确定当前文件类型
- 如果更新了配置中支持的文件类型可能需要重新运行 `:CocInstall coc-XXX` 以升级扩展

### 安装插件

```
nvim +PlugInstall

安装后重启 nvim，检查安装结果

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
find src/**/* -name "*.stories.js" | sort -u
```

### 搜索替换

> http://vimregex.com/

- `:Ag 文本内容`: 搜索项目内包含文本内容的文件，快捷键同文件搜索
- vim 中的非贪婪(non-greedy)模式，不用 `*` 而是 `\{-}`
- vim uses `\_.` to include the newline character to the common `.`
- 交互式替换: `:%s/old/new/gc` ，y 是 n 跳过 a 所有

例：匹配 buckets 数组部分

```json
"pin": {
	"doc_count_error_upper_bound": 0,
	"sum_other_doc_count": 0,
	"buckets": [
		{ "key": "jd_CrOHlwrQEZJa", "doc_count": 216 },
		{ "key": "oppozydt1", "doc_count": 185 },
		{ "key": "jd_71d50d4d544f6", "doc_count": 167 },
	]
}
```

```
/buckets\":\s\[\(\n\_.\{-}\)\]

# 防止 buckets 数组嵌套
/buckets\":\s\[\(\n\_[^\[]\{-}\)\]
```

### 批量复制搜索结果

- :g/PATTERN/yank A

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
- 选择若干列之后输入`:`，命令行中会自动出现 `:'<,'>`
- 输入 `norm A<要输入的字符>`

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

### 对比文件

- nvim -d file1 file2

### 基于 tcomment_vim 的注释

In normal mode:

- gc{motion} 指定方向，motion 即 hjkl 和 ↑（向上的行）↓（向下的行）
- gc<Count>c{motion} 指定数量的
- gcc 当前行

In visual mode:

- gc

---

## 4. Git

### git clone 加速

- 将 github.com 换为 github.com.cnpmjs.org 即可实现加速

### nvm/npm 加速

- NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
- npm config set registry https://registry.npmmirror.com

### git 暂存

- git stash
- git stash pop

### 查看某次 commit 并排除文件

```
git show --pretty <hash> -- . ':(exclude)package-lock.json'
git diff --pretty <hash> ':(exclude)package-lock.json' ':(exclude)src/components/**/*'
git diff 12eefe9159f --author weimanqing ':(exclude)package-lock.json' src/components/CustomReport/ > _change.log
git diff 12eefe9159f '@{2 days ago}' ':(exclude)package-lock.json' src/components/CustomReport/
git diff 12eefe9159f '@{2021-10-22 00:00:00}' ':(exclude)package-lock.json' src/components/CustomReport/
```

### git 删除 untracked files

- git clean -fd

### git 删除分支

- 本地 `git branch -d <分支>`
- 远端 `git push origin --delete <分支>`

### 添加删除 remote url

- `git remote set-url --add origin <git>`
- `git remote set-url --delete origin <git>`

### 从其它分支提取指定文件

- git checkout [branch] -- [file name]

### 分支改名

- 本地分支重命名 `git branch -m old new`
- 删除远程分支 `git push origin :远程分支名`
- 将本地分支推送到远程分支 `git push origin 本地分支名:远程分支名`

### 打 tag

- git tag -a v1.4 -m "my version 1.4"

### 查看仓库信息

- `git remote -v` 或 `git remote show origin`

### 查看已经删除的文件历史

- git log --all -- <路径>

### 按时间筛选 log

- git log --since="Wed Jan 8 20:03:47 2020 +0800" src/_.md src/v3/\*\*/_

---

## 5. Nginx

### 匹配多个路径

> https://nginx.viraptor.info/

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

## 6. npm

### npm 发布

- npm login 或 npm adduser 登录
- npm version x.x.x 或手动改 package.json
- npm publish
- npm home [name] 打开项目主页查看

### npm 使用本地包调试

- 在组件项目根目录 npm link
- 在业务项目根目录 npm link <组件包名>

解除：

- 在业务项目根目录 npm unlink --no-save <组件包名>
  - 如果提示没权限则尝试 sudo rm -rf node_modules/<组件包或域目录>
- 在组件项目根目录 npm unlink

### NVM 下载速度慢

命令行输入

```
NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
```

### NVM 设置默认版本

```
nvm alias default 10
```

### 查看某个包版本信息

```
npm view xxx versions
```

---

## 6. mongodb

### 命令行连接到数据库

```
mongo -host mongodb://xxx

# 查看所有数据库
show dbs

# 使用某数据库
use XXX

# 查看表
show collections

# 查找记录
db.getCollection('collectionXXX').find({key1: value1, ...})

# 查找记录并过滤结果字段 1 包含，0 排除
db.getCollection('collectionXXX').find({}, {col1: 1, col2: 1})
```
