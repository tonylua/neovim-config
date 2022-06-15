## DNS

8.8.8.8
114.114.114.114

## Homebrew

```
/bin/zsh -c "$(curl  -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
```

## Git

```
brew install git
git config --global --add safe.directory /opt/homebrew/Library/Taps/homebrew/homebrew-core
git config --global --add safe.directory /opt/homebrew/Library/Taps/homebrew/homebrew-cask
```

分别生成工作和通用的密钥：

```
ssh-keygen -t rsa -f ~/.ssh/id_rsa.yourcomp -C "yourname@yourcomp.com"

ssh-keygen -t rsa -C "foo@bar.com"
```

配置不同环境下对应的：

`vim ~/.ssh/config`

```
Host *.yourcomp.com
  IdentityFile ~/.ssh/id_rsa.yourcomp
  User yourname@yourcomp.com
```

在各个平台加入公钥，测试：

```
ssh -T git@git.yourcomp.com

ssh -T git@bitbucket.org

ssh -T git@github.com
```

分别在每个工作仓库下设置：

```
git config user.name yourname

git config user.email yourname@yourcomp.com
```

*可能需要*修改 url 部分为 git 格式，以便正确使用公钥私钥：

```
# vim .git/config

[remote "origin"]
    url = git@git.yourcomp.com:CPS/cps-devops.git
    fetch = +refs/heads/*:refs/remotes/origin/*
```

## zsh

```
brew install zsh

chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "alias git='LANG=en_GB git'" >> ~/.zshrc
echo "export LC_ALL=en_US.UTF-8" >> ~/.zshrc
echo "export LANG=en_US.UTF-8'" >> ~/.zshrc
```

## Package Contral (sublimetext)

```
import urllib.request,os,hashlib; h = '6f4c264a24d933ce70df5dedcf1dcaee' + 'ebe013ee18cced0ef93d5f746d80ef60'; pf = 'Package Control.sublime-package'; ipp = sublime.installed_packages_path(); urllib.request.install_opener( urllib.request.build_opener( urllib.request.ProxyHandler()) ); by = urllib.request.urlopen( 'http://packagecontrol.io/' + pf.replace(' ', '%20')).read(); dh = hashlib.sha256(by).hexdigest(); print('Error validating download (got %s instead of %s), please try manual install' % (dh, h)) if dh != h else open(os.path.join( ipp, pf), 'wb' ).write(by)
```

## Vim

```
// ~/.vimrc

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
```

## nvm

After install zsh

- brew update
- brew install nvm
- mkdir ~/.nvm

after in your ~/.zshrc or in .bash_profile if your use bash shell:

```
export NVM_DIR=$HOME/.nvm
source $(brew --prefix nvm)/nvm.sh
```

### nvm/npm 加速

- NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
- npm config set registry https://registry.npmmirror.com

### 查看可用版本

- nvm ls-remote
- nvm ls

### 安装

- nvm install 12

### 使用

- nvm use 12

### 插件

```
brew install tmux

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

brew install the_silver_searcher

# mac 下还需要执行
brew install fzf

# 有时需要加sudo反复执行几次
nvim +PlugInstall

# 安装后重启 nvim，检查安装结果
# 这里会给出详细的提示，有各种不满足的地方按图索骥即可
:checkhealth

# 平时有些插件添加并配置后如果 PlugInstall 也无效，尝试升级解决
:PlugUpgrade
:PlugUpdate

从页面https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/DroidSansMono/complete，下载字体文件；完成后双击打开并点击“安装”并在终端中设置

git clone git@github.com:tonylua/neovim-config.git ~/.config/nvim
```

[初探在 WSL 中设置 vim 前端开发环境](https://juejin.im/post/6844904154796654600)

[在 win10 的 WSL 中设置前端开发环境](https://juejin.im/post/6844903892564574222)

