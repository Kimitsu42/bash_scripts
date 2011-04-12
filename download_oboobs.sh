# папка назначения
dir_to='/home/ki/Загрузки/oboobs.ru'
dir_to='/media/Sata500/downloads/oboobs.ru'


for i in `seq -w 40 99`; do 
  dir="$dir_to/$i"xx

  if [ -d "$dir" ];
  then echo Ok
  else mkdir "$dir"
  fi

  for j in `seq -w 0 99`; do
	wget -c http://media.oboobs.ru/boobs/0$i$j.jpg -P "$dir"
  done

done


