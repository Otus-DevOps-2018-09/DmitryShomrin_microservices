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
