#!/bin/bash

set -e  # Прерываем выполнение при ошибке
set -x  # Включаем отладочный режим

# Убедись, что sshpass установлен на локальной машине
if ! command -v sshpass &> /dev/null; then
    echo "sshpass не установлен. Устанавливаем..."
    sudo apt-get update && sudo apt-get install -y sshpass
fi

# Копируем файлы на удаленный сервер
sshpass -p '123' scp -o "StrictHostKeyChecking=no" -P 2023 src/cat/s21_cat keiraski@192.10.10.2:~ || { echo "Ошибка SCP для s21_cat"; exit 1; }
sshpass -p '123' scp -o "StrictHostKeyChecking=no" -P 2023 src/grep/s21_grep keiraski@192.10.10.2:~ || { echo "Ошибка SCP для s21_grep"; exit 1; }

# Выполняем команды на удаленном сервере
sshpass -p '123' ssh -o "StrictHostKeyChecking=no" keiraski@192.10.10.2 -p 2023 << EOF
echo '123' | sudo -S mv ~/s21_cat ~/s21_grep /usr/local/bin
EOF

echo "Deploy is OK"
