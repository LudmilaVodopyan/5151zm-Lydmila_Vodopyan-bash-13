#!/bin/bash

 # очищаем консоль
 clear

 echo "5151zm-Lydmila_Vodopyan-bash-13 :"
 echo "Краткое описание работы :"
 echo "#1  выводит текущий каталог;"
 echo "#2  ищет в текущем каталоге файл с указанным именем;"
 echo "#3  сравнивает дату изменения индексного дескриптора файла с введенной датой;"


 # 1 #
 echo
 echo "==============================="
 echo "Текущий каталог:"
 echo $PWD
 echo "==============================="
 echo
 # 2
 tryagain=true
     if [ -z "$(ls -A)" ]; then  
        echo "Текущий каталог не содержит файлов."
        exit
      else
         while "$tryagain"; do 
             echo "Введите имя файла:"
	     read filename
             if [[ -f $filename ]]; then
		echo "Файл \"$filename\" найден.."
                tryagain=false
	     else
		echo "Файл с указанным именем \"$filename\" не найден."
	     fi
 	 done
      fi

 echo

 # 3 #
 # Получаем дату
 tryagain=true
 while "$tryagain"; do
     echo
     echo "Введите дату в следующем порядке"
     echo "Год:"
     read year
     echo
     echo "Месяц:"
     read month
     echo
     echo "День:"
     read day

     if [ $(date -d $year-$month-$day "+%Y-%m-%d" > /dev/null  2>&1) ]; then
	echo "Неверный формат даты"
     else
	tryagain=false
	echo
	echo "Дата получена..."
     fi
  done

 echo "Сравнение с датой изменения индексного дескриптора файла..."

 lastmoddate=$(stat -c %Z $filename)
 convertedinputdate=$(date -d $year-$month-$day +"%s")

 if [ $convertedinputdate -lt $lastmoddate ]; then
    echo "После \"$year-$month-$day\" индексный дескриптор файла \"$filename\" менялся."
    exit 120
 else
    echo "После \"$year-$month-$day\" индексный дескриптор файла \"$filename\" не изменялся."
 fi
