cur_time=`date "+%Y-%m-%d_%H-%M-%S"`
if [ ! -d "$PREFIX" ];then
    PREFIX=/usr
else
    echo "$PREFIX已存在，跳过设置"
fi

if [ ! -d "$PREFIX/share/vim/vimfiles" ];then
    echo "vimfiles 文件夹不存在"
else
    mv $PREFIX/share/vim/vimfiles $PREFIX/share/vim/vimfiles_$cur_time
fi

#备份vimrc配置
if [ ! -f "~/.vimrc" ];then
    echo ".vimrc 文件不存在"
else
    mv ~/.vimrc ~/.vimrc_$cur_time
fi

git submodule update --init --recursive
cp .vimrc ~/.vimrc
cp -r vimfiles $PREFIX/share/vim/vimfiles
