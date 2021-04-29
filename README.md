# Установка системы "Feecc" на ОС семейства Debian:

1. Перейти в домашнюю директорию

`cd ~`

2. Установить Git, Vim, Nano если они ещё не установлены

`sudo apt install -y git vim nano`

3. Клонировать этот репозиторий вместе со всеми подмодулями

`git clone https://github.com/arseniiarsenii/feecc_qa_geoscan --recursive`

4. Перейти в директорию "feecc_qa_geoscan"

`cd feecc_qa_geoscan`

5. Отредактировать конфигурационный файл Агента и заполнить в нём **все** поля

`vim Agent/config/config.yaml`

6. Запустить установочный скрипт от имени супер-пользователя

`sudo bash install.sh`

7. По окончании работы скрипта машина перезагрузится