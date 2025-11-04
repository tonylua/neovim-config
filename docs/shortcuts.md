## 1. Chrome

### 全屏截图

- 开发者模式，Command+Shift+P

### 正则过滤请求

```
regexp:jd\.com\/(?!authadmin)
```

### gitlab MR页面隐藏无用记录

```
document.querySelectorAll('.fa-caret-down').forEach(a => a.click())
Array.from(document.querySelectorAll('.diff-file')).filter(a => a.querySelector('small')?.innerText.includes('→ 0')).forEach(a => a.style.display = 'none')
```

---

## 2. 终端

### 有些下载的 dmg 需要先移除 quarantine，将其拖入终端，接在以下命令后面：

```
sudo xattr -r -d com.apple.quarantine
```

### 改变目录下所有层级的权限

- chmod -R 777 ~/.fzf

### 用 vim 编辑命令

- 在终端某条命令上连续按 ctrl+X ctrl+E

### 调出 emoji 表情选择

- control + command + space

### 输入拼音音调

- 中文输入状态
- 输入一个元音
- option + tab 按几次就是几声

### finder 显示隐藏文件

- command + shift + .

### Tmux 常用命令

> 先输入命令 tmux，按 Ctrl+b 激活控制台；此时以下按键生效）：

- `?:` 列出所有快捷键；按 Esc 或 q 返回
- `":` 垂直分割当前窗口
- `%:` 水平分割当前窗口
- `!:` 关闭当前子窗口
- `&:` 确认并退出整个窗口
- 方向键：切换子窗口

调整大小：

- tmux resize-pane -[U|D|L|R] [10]

### 搜索替换

> https://alexharv074.github.io/2019/04/16/a-sed-tutorial-and-reference.html#command-line-options

- mac 下 -i 后面加 ""
- sed -i "s/查找字段/替换字段/gi" `grep 查找字段 -rl 路径`
- grep '正则内容' -rn（或 -rl） src/\*_/_ | sort | uniq
- sed -i 's/查找字段/替换字段/g' `grep "deletable" -rl src/**/* | sort | uniq`
- 排除用 `--exclude` 或 `--exclude-dir`，如 `grep --exclude-dir=node_modules -rn 'no-rem' .`
- `grep -l "pattern" file1 file2 file3` 只显示路径

```
sed -i "" 's/jad-/jadx-/g' `grep "jad-" -rl --exclude="**/*.spec.js" src/components/Cascader/**/*`
grep "-123px" -rn src/**/* --exclude 'src/assets/common2.0'
grep -R --exclude-dir=node_modules "CopyPlugin" ./**/*
```

```
find **/* -name "element-icons.ttf"
find src/**/* -name "*.stories.js" | sort -u
find ../crm_fe -name "*.d.ts" ! -path "*/node_modules/*"
```

### 排除某些文件后删除

- find src/views/Reports/create/\* -type 'f' | grep -v 'index.vue' | xargs rm
- find . -type 'd' | grep -v "NameToExclude" | xargs rmdir

### 排除某些文件后拷贝

- rsync -av --progress sourcefolder /destinationfolder --exclude dir1 --exclude dir2

### 排除某些文件后移动

- mv $(ls | egrep -v '(libs|app1-vue3-webpack5)') app1-vue3-webpack5

### 统计文件个数

- ls -l dir/\*.js | wc -l

### 统计文件体积

- du -hc dist/custom-report/assets/js/\*.js
- c 可读
- h 总数,不带的话结果除 2

### 查看占用

- `lsof -i:端口号`

### 打包

```
zip -vr my_config.zip ~/.config/ -x "*.DS_Store" -x '*node_modules*'
```

```
tar -czvf 打包后生成的文件名全路径 要打包的目录
```

### 解压

```
unzip yourfile.zip -d /path/to/destination

tar -xzvf yourfile.tar.gz -C /path/to/destination
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

### chrome 插件位置

~/Library/Application Support/Google/Chrome/Default/Extensions

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

### 找到应用位置

- which nvim

### 查看软连接指向

- ln -l 软链接

### 模拟tree

```
find <PATH> -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
```

### 拷贝目录

cp -r a/b/ c/bCopy/

### 下载youtube

- pip 安装 yt-dlp
- 查看分辨率列表等 `yt-dlp -F URL`
- 指定分辨率下载 `yt-dlp -f 数字代码 URL`
- 指定输出模版 `yt-dlp -o "%(title)s.%(ext)s" URL`
- 断点续传 `-c`

### PS 查找程序路径

```
(Get-Command nvim).Path
```

### PS查找文件

- `Get-ChildItem -Path "./" -Recurse -Filter "ainow.db" -File | Where-Object { $_.FullName -notmatch "\\dist\\?" }`

### PS删除目录

- `Remove-Item -LiteralPath "foldertodelete" -Force -Recurse`

```删除所有node_modules
Get-ChildItem -Recurse -Directory -Filter node_modules | Remove-Item -Recurse -Force
```

### 在 PowerShell 中，`grep -rn "some" ./**/*` 的等效实现

```
Get-ChildItem -Recurse | Select-String -Pattern "some" -List | Format-Table Path, LineNumber, Line -AutoSize
```

### V2rayn "运行Core失败"

找出占用v2rayn端口的进程并kill:

```
netstat -ano | findstr ":10809"
taskkill /PID 68008 /F
```

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

### 查看当前文件路径

- ctrl+G

### 预览定义

> https://github.com/rmagatti/goto-preview

在变量等处直接输入:

- 预览 gpd
- 跳转 gd
- 关闭所有预览 gP

### 补全光标处模块的import

- ga

### 找到匹配的括号等

- %

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

- 在指定目录中递归搜索内容

```
:Rag <搜索词> <目录>
```

### 非捕获分组

- `\%\(xxx\)`

### 替换捕获到的部分

```
:%s/\v\.ant-form-control(:{0,2}\S+)?/.ant-input\1,&/g
```

### Negative/Positive Lookahead

- `\(\n\)\@!` or `\(\n\)\@=`

### 删除空行

- `:g/^$/d`

### 批量复制搜索结果

- :g/PATTERN/yank A

### 清除搜索高亮

- `:noh`

### 环绕引号等

> https://zhuanlan.zhihu.com/p/158604935

常规模式下：

- 单词： `ysiw"` `ysiwt<span>`
- 整行： `yss"` `ysst<li>`

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

### 跳转到历史文档

- CTRL-O 退后
- CTRL-I 向前

### 跳转到指定行

- `ngg`
- `nG` （跳转到文件第 n 行，无需回车）
- `:n` （跳转到文件第 n 行，需要回车）

### 退出 recording 模式

- 在非 insert 状态下按 q 键

### 新建 split 窗口

- :new / :vnew
- :split / :vsplit (打卡当前文件)

### 挪动 split 窗口位置

- Ctrl + w，R 向上/向左
- Ctrl + w，r 向下/向右

### 挪动 tab

- :tabm n

### 在两个并排 split 窗口比对 diff

- 用 `:vnew` 新建 split
- 在两个 split 里贴好内容
- 运行 `:windo diffthis` 开启对比 (`diffoff` 可关闭对比)
- 先 ] 后 c 跳转到下一个差异点：`]c` ，反向跳转是：`[c`

### 折叠

- 多行选择后，`zf` / `zd`

### 书签

> https://www.yiibai.com/vim/vim_markers.

- m{bookmark-name} 然后 "`{bookmark-name}"
- 列出所有 :marks
- :delmarks {bookmark-name}

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

### 打开文件

- `:edit FILEPAT`

### 查看完整的 lsp 错误提示

- `:LspDiagLine`

### 查看当前文件路径

```
:echo expand('%:p')
```

---

## 4. Git

### git clone

- 加速：将 github.com 换为 github.com.cnpmjs.org 即可实现加速

- 特定版本： git clone -b BRANCH --depth 1 git@github.com:XXX.git

- 仓库过大报错 fetch-pack: unexpected disconnect while reading sideband packet

```
git config --global http.postBuffer 524288000
git config --global http.version HTTP/1.1
git config --global core.compression 0
# 如果网络环境不太好，可以通过增加下面的参数，降低失败率：
git config --global http.lowSpeedLimit 0
git config --global http.lowSpeedTime 999999
git config --global core.compression 0
```

### git 暂存

- git stash
- git stash pop

### raw.githubusercontent.com 找不到

- 替换成 raw.fastgit.org 或 raw.staticdn.net

### Failed to connect to github.com port 443

- 打开 https://github.com.ipaddress.com/ 查看ip
- /etc/hosts 里 140.82.112.3 github.com

### 报错： HTTP/2 stream 1 was not closed ...

- git config --global http.version HTTP/1.1

### Warning: Remote Host Identification Has Changed

- `nvim ~/.ssh/known_hosts` 删除对应的

### 只克隆Git仓库中的子目录

方法1

git clone --filter=blob:none --no-checkout --depth 1 --sparse <project-url>
cd <project>
git sparse-checkout add <folder1> <folder2>
rm .gitignore
git checkout

方法2 - 会下载大量不可见的文件：

- git init
- git remote add -f origin <repository-url>
- git config core.sparsecheckout true
- echo "<subdirectory-path>" >> .git/info/sparse-checkout （每行可以配置一个文件或目录）
- git pull --depth=1 origin master （第一次之后可以不加 origin master ）

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

- 如删除失败则 `git fetch --prune origin` 后 `git branch -r` 再看

### 添加删除 remote url

- `git remote set-url --add origin <git>`
- `git remote set-url --delete origin <git>`

#### 为每个仓库添加独立别名

```
git remote remove origin  # 完全删除 origin
git remote add bitbucket git@bitbucket.org:tonylua/ainow-ui.git
git remote add gitlab https://gitlab.xpaas.lenovo.com/scet/ainow-ui.git
# 分别推送
git push bitbucket edge/dev
git push gitlab edge/dev
```

### 从其它分支提取指定文件

- git checkout [branch] -- [file name]

### 分支改名

- 本地分支重命名 `git branch -m old new`
- 删除远程分支 `git push origin :远程分支名`
- 将本地分支推送到远程分支 `git push origin 本地分支名:远程分支名`

### 打 tag

- git tag -a v1.4 -m "my version 1.4"
- git tag -d v1.4 // 删除
- git push origin v1.4

### 查看仓库信息

- `git remote -v` 或 `git remote show origin`

### 查看并恢复已删除的文件

```
git log --diff-filter=D --summary | grep delete
git log --all -- <FILE>
git shwo <COMMIT> -- <FILE>
git checkout <COMMIT>^ -- <FILE>
```

### 按时间筛选 log

- git log --since="Wed Jan 8 20:03:47 2020 +0800" src/_.md src/v3/\*\*/_
- git log --author xxx --graph --after 2022-12-30 --before 2022-12-31

### 一周的 commit messages

- git log --since="7 days ago" --oneline

### 修改上次 commit message

- git commit --amend
- 或者 `git rebase -i` 后将对应 commit 改为 r 后保存退出，在新的窗口中修改
- git config --global core.editor "vim"

### reset/rebase 后恢复

- git reflog 查看 hash
- 再次 reset --hard

### 统计代码量

```
git log --shortstat --since="1 year ago" --until="now" \
  | grep "files changed\|Author\|Merge:" \
  | awk '{ \
    if ($1 == "Author:") {\
      currentUser = $2;\
    }\
    if ($2 == "files") {\
      files[currentUser]+=$1;\
      inserted[currentUser]+=$4;\
      deleted[currentUser]+=$6;\
    }\
  } END {\
    for (i in files) {\
      print i ":", "files changed:", files[i], "lines inserted:", inserted[i], "lines deleted:", deleted[i];\
    }\
  }'
```

### 打印TODO清单

> https://medium.com/pragmatic-programmers/git-config-core-pager-807e17d64243

先设置 git paper (默认为 less):

```
git config --global core.pager "cat"
```

```
grep "TODO" -rn src/**/* --exclude="src/out/**/*" | uniq | awk -F : 'BEGIN{count=0}; {count++}; { print "\n" $1 " [" $2 "行]" }; { system("git blame -L " $2 "," $2 " " $1) } END{print "\n总共 " count " 项"}' > todo-list.txt

```

### 清除git代理

```
git config --global --unset http.proxy
git config --global --unset https.proxy

---

## 5. Nginx

### 匹配多个路径

> https://nginx.viraptor.info/

```

#匹配/node /info /search
location ~\* ^/(node|info|search)/ {
proxy_pass http://localhost:8080;
}

#绝对匹配一个路径 /info
#location ^~ /info/ {

# proxy_pass http://localhost:8080;

#}

````

### 指定配置文件启动

- nginx -c 绝对路径

### 重启和关闭

- nginx -s reload
- nginx -s stop

### 手动关闭

- ps -ef | grep nginx
- kill -QUIT 主进程（master）号

---

## 6. npm

### nvm/npm 加速

- NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
- npm config set registry https://registry.npmmirror.com
- 或 npm config set registry https://registry.npm.taobao.org/
- npm config rm registry
- npm config set electron_mirror "https://npm.taobao.org/mirrors/electron/"
- yarn config set registry https://registry.npm.taobao.org/
- yarn config get registry
- pnpm config set registry https://registry.npm.taobao.org
- pnpm config list
- pnpm config delete @jd:registry
- npm config set strict-ssl false

### 部分包加速(存疑)

> https://www.runjf.com/nodejs/npm-add-binary-mirror

- `npm view sqlite3 binary` 获取 module_name，如 node_sqlite3
- `pnpm config set <module_name>_binary_host_mirror https://npm.taobao.org/mirrors`

### 如果运行时 sqlite3 报错

- 尝试运行如下命令覆盖
- 注意命令中的版本等信息，或许要根据 _本机规格_ 或 _依赖版本_ 找到[镜像版本列表](https://registry.npmmirror.com/binary.html?path=sqlite3/)手动调整

```bash
curl https://cdn.npmmirror.com/binaries/sqlite3/v5.1.4/napi-v6-darwin-unknown-arm64.tar.gz | tar -zx -C ./node_modules/.pnpm/sqlite3@5.1.4/node_modules/sqlite3/lib/binding/
````

### 解决peer失败

- pnpm config set auto-install-peers true

### npm 发布

- npm login 或 npm adduser 登录
- npm version x.x.x 或手动改 package.json
- npm publish
  - 发布以@开头命名的包，首次发布必须要带参数: `--access public`
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

### 查看某种已安装的包

```
npm ls | grep storybook
```

### pnpm 查看依赖关系

```
pnpm why xxx
```

### `pnpm i` 报错：`⨯ cannot execute  cause=fork/exec C:\Users\luanluan\AppData\Local\nvm\v20.18.2\node_modules\pnpm\bin\pnpm.cjs: %1…`

- 打开报错中的 pnpm.cjs，[第一行改为 `#!node`](https://github.com/pnpm/pnpm/issues/5638#issuecomment-1327988206)

### pnpm 清缓存

```
pnpm store prune
```

### prisma报错 `Error validating datasource `db`: the URL must start with the protocol `prisma://``

- `rm -Recurse .\node_modules\.pnpm\@prisma+client@5.3.1_prisma@5.3.1\`
- `pnpm i`

### 查看nodejs目录等

```
npm config get prefix
npm config get cache
npm config ls
```

### 使用pnpm的patch命令打补丁

- https://juejin.cn/post/7119369833187115039

### 创建electron项目

- `npx create-electron-app@latest my_electron_1 --template=vite`
- 报错 `An unhandled rejection has occurred inside Forge...try installing again at getElectronPath`:
  ```
  node node_modules/electron/install.js
  ```

---

## 7. mongodb

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

---

## 8. Python

### 安装特定版本

```
wget https://www.python.org/ftp/python/3.7.17/Python-3.7.17.tar.xz
tar -xf Python-3.7.17.tar.xz
cd Python-3.7.17
./configure --enable-optimizations --with-lto --prefix=/usr/bin/python3.7.17
make -j 4 # cpu核数
sudo make altinstall
sudo ln -sf /usr/bin/python3.7.17/bin/python3.7 /usr/bin/

python3.7 -V
```

### 临时修改 /tmp 容量（pip install 等）

mount -o remount,size=2G /tmp

### pip 查看软件版本

pip index versions xxx

### pip 加速

pip install XXX -i https://pypi.tuna.tsinghua.edu.cn/simple

### 虚拟环境

```
创建：
python -m venv XXX
特定版本创建：
python3.7 -m venv XXX
激活：
source XXX/bin/activate
```

### y2b venv 迁移到 uv

- pipx install uv
- pipx ensurepath
- source ~/.zshrc
- uv venv --python 3.12 .venv
- source .venv/bin/activate
- uv pip list
- uv init
- uv add -r requirements.txt && rm requirements.txt

### uv 安装依赖

```
uv pip install googletrans
```

### uv 升级依赖

```
uv add "httpx>0.1.0" --upgrade-package httpx
```

---

## 9. Rust

### 查找某个包的版本

```
cargo search XXX
```

### 升级到 nightly

```
rustup default nightly; rustup update
```

---

## 10. WSL

### 改wsl主机名

- `sudo hostnamectl set-hostname lenovoWSL`

### WSL和Windows共享SSH私钥

- https://juejin.cn/post/7202901118451941431

### 安装curl

- https://www.cnblogs.com/cobcmw/p/12616305.html

### python别名

- `sudo apt install python-is-python3`

### 安装zsh

- https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
source .zshrc
```

### 安装nvm

- https://idroot.us/install-nvm-debian-12/

### raw.githubusercontent.com:443'

- https://zhuanlan.zhihu.com/p/115450863

### 安装neovim

- <del>[安装neovim 0.7不兼容插件](https://github.com/neovim/neovim/wiki/Installing-Neovim/921fe8c40c34dd1f3fb35d5b48c484db1b8ae94b#debian)</del>
  - sudo apt-get install apt-show-versions
  - apt-show-versions -a neovim

```
sudo apt-get install wget
wget https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage && ./nvim-linux-x86_64.appimage --appi
mage-extract
./squashfs-root/AppRun --version
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
```

- 字体图标

在 Terminal 的 debian 选项里更改字体

<del>
```
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/DroidSansMono.zip
sudo apt-get install unzip
unzip DroidSansMono.zip -d ~/.fonts
fc-cache -fv
```
</del>

- neovim 插件

```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

nvim +PlugInstall +qall

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

nvim +PackerInstall

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

sudo apt install silversearcher-ag
```

---
