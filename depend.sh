if [ ! -f "$(which pacman)" ];then
    if [ ! -f "$(which yum)" ];then
        if [ ! -f "$(which apt)" ];then
            echo "没有找到了apt package manager"
        else
            pkg_exec="apt install"
            echo "找到了apt package manager"
        fi
    else
        pkg_exec="yum install"
        echo "找到了yum package manager"
    fi
else
    pkg_exec="pacman -S"
    echo "找到了pacman package manager"
fi

$pkg_exec vim ctag
