## Part 1. Настройка gitlab-runner

Поднял виртуальную машину Ubuntu Server 22.04 LTS.
![alt text](scrin/1.png) 

Скачал и установил на виртуальную машину gitlab-runner.
![alt text](scrin/2.png) 
Дал разрешение на запуск
![alt text](scrin/3.png) 

Запустил gitlab-runner и зарегистрировал его для использования в текущем проекте (DO6_CICD).
![alt text](scrin/4.png)

Так же необходимо установить на машину gcc make clang-format (и sshpass в моем случае)
![alt text](scrin/4.1.png)

Для регистрации понадобятся URL и токен, которые можно получить на страничке задания на платформе.
![alt text](scrin/5.png)

## Part 2. Сборка

Напишисал этап для CI по сборке приложений из проекта C2_SimpleBashUtils.

В файле gitlab-ci.yml добавила этап запуска сборки через мейк файл из проекта C2.
![alt text](scrin/6.png)
Файлы, полученные после сборки (артефакты), сохранил в произвольную директорию со сроком хранения 30 дней.

Запушил проект Pipeline запустился автоматически 
![src/scrin/7.png ](scrin/6.1.png) 

В случае неуспешного запуска открыть файл /home/gitlab-runner/.bash_logout

![src/scrin/7.png ](scrin/6.2.png) 
и закоментировать условие
![src/scrin/7.png ](scrin/6.3.png) 

после этого должно заработать

![src/scrin/7.png ](scrin/6.1.png) 

## Part 3. Тест кодстайла

Напишисал этап для CI, который запускает скрипт кодстайла (clang-format).

![src/scrin/7.png ](scrin/7.png) 

Pipeline запустился и отработал без ошибок
![src/scrin/7.png ](scrin/7.1.png) 

## Part 4. Интеграционные тесты


Написал этап для CI, который запускает  интеграционные тесты из того же проекта.
![src/scrin/9.png](scrin/8.png)
Условия запуска этого этапа стоят автоматически только при условии, если сборка и тест кодстайла прошли успешно.

dependencies:
- build-code
- style-check-cat
- style-check-grep

Если тесты не прошли, то «зафейли» пайплайн.
В пайплайне отобразила вывод, что интеграционные тесты успешно прошли / провалились.
![src/scrin/11.png](scrin/9.png)
## Part 5. Этап деплоя


Поднял вторую виртуальную машину Ubuntu Server 22.04 LTS.
![src/scrin/10.png](scrin/10.png)
Настроил сеть между машинами
![src/scrin/11.png](scrin/11.png)
![src/scrin/12.png](scrin/12.png)
Машины пингуются между собой
![src/scrin/13.png](scrin/13.png)
Написал этап для CD, который «разворачивает» проект на другой виртуальной машине.
![src/scrin/14.png](scrin/14.png)


Запустил этот этап вручную при условии, что все предыдущие этапы прошли успешно.
![src/scrin/15.png](scrin/15.png)



Напишисал bash-скрипт, который при помощи ssh и scp копирует файлы, полученные после сборки (артефакты), в директорию /usr/local/bin второй виртуальной машины.




В файле gitlab-ci.yml добавил этап запуска написанного скрипта.
![src/scrin/18.png](scrin/16.png)

Этап деплоя запущенный вручную выполнился без ошибок
![src/scrin/19.png](scrin/17.png)

Проверяем выполнение и видим, что исполняемые файлы сохранены на второй машине.
![src/scrin/19.png](scrin/18.png)

Сохранил образы
![alt text](scrin/19.png)


## Part 6. Дополнительно. Уведомления

Написал bash скрипт для отправки уведомлений в телеграм бот об успешном/неуспешном выполнении пайплайна.
![src/scrin/20.png](scrin/20.png)

Настроил yml файл чтобы после каждого этапа отправлялось уведомление в телегармм.
![src/scrin/21.png](scrin/21.png)

Успешная работа телеграмм бота
![src/scrin/22.png](scrin/22.png)