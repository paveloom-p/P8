#! /bin/bash

echo ""
echo "     Для какого фильтра обновить главную процедуру?"

while true; do
     read -p "     " answer
     case $answer in
          [Jj] ) FILTER_FOLDER="J"; FILTER="j"; COUNTER=61; break;;
          [Kk] ) FILTER_FOLDER="K"; FILTER="k"; COUNTER=60; break;;
          [Hh] ) FILTER_FOLDER="H"; FILTER="h"; COUNTER=61; break;;
          * ) echo ""; echo "     Выберете из следующих вариантов: J, H, K."; echo "";;
     esac
done

# Обновление процедуры star.prg
sed -i "3 s/SET.*/SET\/MIDAS_SYSTEM\ DPATH=\.\.\/Данные\/${FILTER_FOLDER}/" star.prg

# Обновление процедуры main.prg
printf "ECHO/OFF\n\n" > main.prg

printf ""

printf "@@ star ${FILTER}1.fit 1 1 1\n" >> main.prg

if [ $COUNTER == 60 ]; then

     for i in {2..60}
     do
          printf "@@ star ${FILTER}${i}.fit 0 1 ${i}\n" >> main.prg
     done

else

     for i in {2..61}
     do
          printf "@@ star ${FILTER}${i}.fit 0 1 ${i}\n" >> main.prg
     done

fi

printf "\n     Процедура main.prg обновлена.\n\n"
printf   "     Рекомендуется настроить дисплей перед\n"
printf   "     запуском с помощью процедуры pre.prg.\n\n"