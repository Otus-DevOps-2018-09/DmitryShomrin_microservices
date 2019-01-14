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
