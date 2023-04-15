# 1
# Написать bash-скрипт, который добавляет в конец лог-файла script.log строчку "DATE: Started”,
#где DATE - дата и время запуска скрипта.
# Например:
# ~$ ./script.sh
# ~$ ./script.sh
# ~$ ./script.sh
# ~$ cat logfile.log
# Чт. июня  5 09:26:38 MSK 2014: Started
# Чт. июня  5 09:26:53 MSK 2014: Started
# Чт. июня  5 09:26:54 MSK 2014: Started
#
# 2
# Дополнить скрипт из предыдущего задания так, чтобы он получал четыре параметра при запуске в командной строке и
#выводил их на экран по одному на новой строчке и также записывал их в лог-файл.
# Если хотя бы один параметр пустой или одного из них не хватает, скрипт должен вместо параметров выводить на экран
#сообщение о том, что ему необходимо передать 4 непустых параметра при запуске.
#
# Например:
# ~$ ./script.sh par1 par2 par3 par4
# par1
# par2
# par3
# par4
# ~$ ./script.sh par1 par2 par3
# ERROR: You need to provide 4 parameters
#
# 3
# Дополнить скрипт из предыдущего задания так, чтобы в случае успешного прохождения проверки на наличие параметров,
# он не распечатывал их (сохранение в лог-файл необходимо оставить), а проверял текст первого параметра на то,
# что он начинается со строк "ftp://”, "http://” или "https://”. Если это так, первый параметр должен выводиться на экран.
# Если нет, на экран должно выводиться сообщение о том, что первый параметр должен начинаться с одной из этих строк.
#
# Например:
# ~$ ./script.sh http://test par2 par3 par4
# http://test
# ~$ ./script.sh par1 par2 par3
# ERROR: You need to provide 4 parameters
# ~$ ./script.sh par1 par2 par3  par4
# ERROR: First parameter should start with "http://”, "ftp://” or "https://”
#
# 4
#
# Дополнить скрипт из предыдущего задания так, чтобы в случае успешного выполнения проверки из предыдущего задания
# и сохранения информации в лог он пытался получить и записать содержимое страницы в текстовую переменную.
# При этом необходимо считать, что адрес страницы передан в первом параметре скрипта.
# Доступ к этому адресу защищен логином и паролем, а логин и пароль переданы во втором и третьем параметре
# скрипта соответственно. Если информацию получить не удается, необходимо вывести причину ошибки на экран.
# Если удается - необходимо вывести на экран сообщение об успехе.
#
# Например:
# ~$ ./script.sh http://site.ru/filename.txt LOGIN PASSWORD par4
# Everything is OK!
# ~$ ./script.sh http://site.com/filename.txt LOGIN PASSWORD par4
# ERROR: Cannot connect to http://site.com/filename.txt: 403
# ~$ ./script.sh http://site.com/filename.txt LOGIN PASSWORD par4
# ERROR: Cannot connect to http://site.com/filename.txt: incorrect login or password
# ~$ ./script.sh http://asdasdasd LOGIN PASSWORD par4
# ERROR: Cannot connect to http://asdasdasd: Name resolution failed
#
# 5
# Дополнить скрипт из предыдущего задания так, чтобы в случае успешной загрузки данных он проверял их на наличие
# вхождения в любом месте этих данных четвертого параметра и, если вхождение есть, выводил бы на экран текст "OK”,
# а если вхождения нет - текст "FAIL”. После этого скрипт должен записывать в лог-файл текст результата и информацию о том,
# что выполнение скрипта завершено.

#!/bin/bash

# Check parameter count
if [ $# = 4 ]; then
  :
else
  echo -e "\033[0;31mERROR: You need to provide 4 parameters\033[0m"
  exit 1
fi

# Check first parameter
if [[ $1 == http://* ]] || [[ $1 == https://* ]] || [[ $1 == ftp://* ]]; then
echo $1
else
  echo -e "\033[0;31mERROR: First parameter should start with http://, ftp:// or https://\033[0m"
  exit 1
fi

# Add date + parameters to log file
date >> ./log
cat << eof >> ./log
$1
$2
$3
$4
eof

# Try to curl
#data_file=$(curl --user $2:$3 $1)

# Grep data
data_file=$(date)

if echo $data_file | grep -q $4; then
  echo -e "\033[0;32m OK!\033[0m"
  echo $data_file | grep $4 >> ./log
else
  echo -e "\033[0;31mFAIL!\033[0m"
fi
