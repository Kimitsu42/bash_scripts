#!/bin/bash
# скрипт качает ролики с redtube.com
# требуется указать существующую папку назначения и диапазон закачки
# докачка роликов поддерживается, но страницы с роликами качаются по
# всему диапазону

dir_to='/media/Sata500/downloads/redtube.com'

from=175
to=1000

# 1 11 13 332 342 708 2186 6034



# функция закачки файла ('patch/to/dir', 'file_num')
function load_file {
echo "Загружаем файл $2 в папку $1"

# закачиваем страницу с роликом
wget -q http://www.redtube.com/$2 -O "$1/$2"

# определяем заголовок и ссылку
title=$(cat "$1/$2" | grep -o "<title>.*" | grep -oP '[a-zA-Z -]*(?= - RedTube)');
url=$(echo $(echo -n `cat "$1/$2" | grep hashlink` | \perl -pe's/\%([A-Fa-f0-9]{2})/pack('C', hex($1))/seg') | grep -o "http://cdn.ec.redtube.com/_videos_[a-zA-Z0-9/.?]*" | grep --max-count=1 http);

#echo $title
#echo $url
#echo $rt >> "$dir/log"
#echo $title >> "$dir/log"

# закачиваем ролик
wget -cq $url -O "$1/$2 $title.avi"

# удаляем страницу с роликом
rm "$1/$2"

}




# цикл, создающий папки и вызывающий функцию закачки
for file_num in `seq  $from $to`; do 
    dir_num=$[ $file_num / 100 ]
    dir="$dir_to/$dir_num"xx

    if [ -d $dir ]; 
    then echo "Directory exists"
    else mkdir $dir
    fi

    load_file $dir $file_num 
done 




exit 
