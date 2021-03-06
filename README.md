# DmitryShomrin_microservices
DmitryShomrin microservices repository

***
Docker-1
Выполнено:
 - Установлен Docker
 - Ознакомился с командами docker ps, images, run, start, attach, exec
 - Сделал commit контейнера
 - Проанализировал различия между образом и контейнером

***
Docker-2
Выполнено:
 - Создан проект в GCP
 - Сконфигурирован gcloud для работы с новым проектом
 - Создан docker-host
 - Повторил практику из лекции
 - Создан Dockerfile, описывающий развертывание приложения в контейнере
 - Собрал образ и опубликовал его на dockerhub
 - Создал директорию infra с папками ansible, packer, terraform
 - Создал шаблон packer с установкой python и docker
 - Создал файлы terraform для поднятия инфраструктуры в облаке
 - Написал несколько ansible-playbook'ов для провижинера пакера и для копирования образа контейнера с dockerhub'а и его старта

 Как запустить:
 ```
cd docker-monolith/infra/
packer build -var-file=packer/variables.json packer/docker_app.json 
cd terraform && terraform init && terraform apply
# Добавить в inventory ip созданного хоста
cd ../ansible 
ansible-playbook playbooks/start.yml
```

***
Docker-3
Выполнено:
 - Написал 3 Dockerfile'а, для развертывания приложения в микросервисной архитектуре
 - Создал сеть для контейнеров
 - Запустил контейнеры и соеднинил их в сети
 - Перезапустил контейнеры с другими сетевыми алиасами без их пересборки
 - Собрал образ на основе Alpine Linux
 - Добавил volume для mongodb

Команды для запуска контейнеров с другими сетевыми алиасами:
```
docker run -d --network=reddit --network-alias=post_db_newalias --network-alias=comment_db_newalias -v reddit_db:/data/db mongo:latest
docker run -d --network=reddit --network-alias=post_newalias -e "POST_DATABASE_HOST=post_db_newalias" dmitryshomrin/post:1.0
docker run -d --network=reddit --network-alias=comment_newalias -e "COMMENT_DATABASE_HOST=comment_db_newalias" dmitryshomrin/comment:3.0
docker run -d --network=reddit -p 9292:9292 -e "POST_SERVICE_HOST=post_newalias" -e "COMMENT_SERVICE_HOST=comment_newalias" dmitryshomrin/ui:3.0

```

***
Docker-4
Выполнено:
 - Запустил контейнеры с разными network driver
 - Создал две сети: front_net, back_net
 - Написал docker-compose.yml и параметризовал его
 - Задал переменные в файле .env
 - Создал файл docker-compose.override.yml

Имя проекта можно задать с помощью переменной `COMPOSE_PROJECT_NAME` или ключом -p при старте

***
gitlab-ci-1
Выполнено:
 - Создал инфраструктурный репозиторий для поднятия инстанса с установленным докером
 - С помощью packer'а создал образ с докером (ansible в качестве провижинера)
 - С помощью terraform'а поднял инстанс
 - Установил gitlab
 - Настроил первый проект, добавил в него код приложения и выполнил тестирование

***
gitlab-ci-2
Выполнено:
 - В gitlab создал еще один проект
 - Добавил раннер в новый проект
 - Добавил dev, staging, prod окружения
 - В stage и prod окружениях сделал запуск "по кнопке"
 - Добавил условие наличия тега
 - Настроил динамическое окружение для каждой новой ветки

***
Monitoring-1
Выполнено:
 - Развернул prometheus и приложение с помощью docker-compose
 - Посмотрел helthcheck'и
 - Использовал node ecxporter для мониторинга виртуальной машины
 - Запушил образа контейнеров в dockerhub
 - Для мониторинга БД использовал percona/mongodb_exporter
 - Для blackbox мониторинга использовал google/cloudprober
 - Написал Makefile для сборки и пуша образов

Ссылки на образа dockerhub:
 ```
https://cloud.docker.com/u/dmitryshomrin/repository/docker/dmitryshomrin/cloudprober
https://cloud.docker.com/u/dmitryshomrin/repository/docker/dmitryshomrin/cloudprober
https://cloud.docker.com/u/dmitryshomrin/repository/docker/dmitryshomrin/ui
https://cloud.docker.com/u/dmitryshomrin/repository/docker/dmitryshomrin/post
https://cloud.docker.com/u/dmitryshomrin/repository/docker/dmitryshomrin/comment
 ```

***
Monitoring-2
Выполнено:
 - Установил Grafana
 - Использовал готовый dashbord для мониторинга Docker и системы
 - Создал свой dashbord для мониторинга ui
 - Добавил график количества запросов к UI
 - Использовал rate для наблюдения изменения количества запросов и запросов с неверным адресом за единицу времени
 - Добавил график с 95 процентилем времени ответа на запрос
 - Создал dashbord с бизнес метриками
 - Настроил alertmanager для отправки в slack сообщений в случае недоступности одной из наблюдаемых систем
Ссылка на dockerhub с образами:
https://cloud.docker.com/u/dmitryshomrin/repository/list

***
Logging-1
Выполнено:
 - Использован стэк EFK
 - Использован fluentd для обработки логов в формате json
 - Составил конфигурацию fluentd для обработки обоих форматов лог сообщений от UI сервиса
 - Развернут Zipkin и с его помощью выполнена трассировка запросов

***
Kubernetes-1
Выполнено:
 - Прошел Kubernetes The Hard Way
 - Проверил, что kubectl apply -f проходит по созданным до этого deployment-ам и поды запускаются
 - Удалил кластер после прохождения THW

***
Kubernetes-2
Выполнено:
 - Развернул локальное окружение для работы с Kubernetes и использовали его для разворачивания reddit app
 - Резвернул kubernetes в GKE, развернули reddit в dev namespace

***
Kubernetes-3
Выполнено:
 - Проверил отсутсвие связности при выключенном kube-dns
 - Использовал load blancer для доступа к приложению
 - Использовал ingress для доступа к приложению
 - Защитил сервис при помощи TLS
 - Описал созданный объект secret в виде k8s манифеста
 - Настроил network policy для mongodb
 - Использовал google диск для хранения томов базы данных
 - Использовал PersistentVolume для хранения томов бд
 - Использовал динамическое выделение volume с использование SSD

***
Kubernetes-4
Выполнено:
 - Описал деплой приложения при помощи chart-ов helm-а
 - Развернул при помощи helm приложение
 - Поправил конфигурацию приложения
 - Обновил установленное helm-ом приложение
 - Развернул Gitlab в kubernetes
 - Настроил CI/CD для приложения в Gitlab

***
Kubernetes-5
Выполнено:
 - Установил prometheus в кластер
 - Добавил в prometheus job для сервисов ui post и comment
 - Развернул grafana, добавили в нее мониторинг kubernetes, бизнес логики и UI
 - Создал переменную namespace и изменил дашборды для мониторинга reddit по отдельности в разных namespaces
 - Загрузил дэшборд kubernetes deployment metrics
