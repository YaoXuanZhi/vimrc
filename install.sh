cur_time=`date "+%Y-%m-%d_%H-%M-%S"`
mv /usr/share/vim/vimfiles /usr/share/vim/vimfiles_$cur_time
mv ~/.vimrc ~/.vimrc_$cur_time

git submodule update --init --recursive
cp .vimrc ~/.vimrc
cp -r vimfiles /usr/share/vim/vimfiles
