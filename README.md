>这是一个本人自用的vim快速部署仓库，依赖git来完成自动化部署。

#### 安装Git和Vim
在Msys2中安装
```sh
pacman -S git vim
```

在CentOS中安装
```sh
yum install git
yum install vim
``` 

#### 自动Vim部署vimrc
在终端下执行以下指令即可
```sh
git clone https://github.com/YaoXuanZhi/vimrc.git vimrc
cd vimrc && sh install.sh
```

最后在终端启动Vim，执行`:PluginInstall`，此时会自动下载其它vim插件 