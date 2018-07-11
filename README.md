>这是一个本人自用的vim快速部署仓库，依赖git来完成自动化部署，多用于在Linux下、Msys，Cmder下慎用吧，直接替换vimrc有小几率会出现块状选择区，这个是因为Cmder的主题配置那边起了冲突，因此，在Cmder下独自安装Vim插件即可。

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
