>这是一个本人自用的vim快速部署仓库，依赖git来完成自动化部署，多用于Linux、Msys环境部署。注意，在Cmder下慎用，直接替换vimrc会有小几率会出现块状选择区，这个是因为Cmder的主题配置那边起了冲突，因此推荐手动安装Vim插件。

#### 安装Git和Vim
>注意,最好先将home添加到windows系统的环境变量中,这样子,各种伪终端环境都可以用到同一份配置了

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
