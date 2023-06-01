1. Оркестратор для docker контейнеров. В этом режиме Docker можно запустить контейнеры на нескольких хостах, объединив их в общем пуле вычислительных ресурсов

```
docker swarm init
```
2. Добавляем в swarm overlay-сеть ana-overlay, которая позволяет создавать виртуальные сети, объединяющие контейнеры, работающие на разных хостах в Docker-кластере. Она обеспечивают межхостовую связь и коммуникацию между контейнерами, как будто они работают в одной сети.
```
docker network create --driver overlay --attachable ana-overlay
```

Содержимое docker-compose.yml

    1. Kafka брокер в однонодовой инсталляции + Xookeeper т.к. для запуска сервера Apache Kafka требуется сначала запустить его сервер
    2. Контейнеры mongodb-source и mongodb-target с базами данных, mongodb-source-setup и mongodb-target-setup для настройки replica set
    3. Контейнер kafka connect, которые соединяет базы данных с Kafka
    4. SchemaRegistry - позволяет разработчикам управлять совместимостью схем, добавлять новые версии схемы и обновлять существующие схемы без прерывания работы системы
    5. Kafka UI - инструмент с графическим интерфейсом для управления и мониторинга Apache Kafka, управления и отслеживания топиков, сообщений и потребителей.
    6. http-client - для HTTP запросов, которые понадобятся для создания в kafka-connect коннекторов

3. Создание и запуск контейнеров
```
docker compose up
```

4. Создание коннекторов
```
docker compose exec -it http-client sh
cd ~
./source.sh
./target.sh
```

5. Вход в source-db
```
docker compose exec -it mongodb-source mongosh
```
Добавление объекта
```
db.users.insertOne({
  "_id": Number(1),
  "firstname": String("ana"),
  "lastname": String("mrzv"),
  "age": Number(20),
  "email": String("test@mail.ru")
})
```

6. Вход в target-db
```
docker compose exec -it mongodb-target mongosh
```
Добавление объекта
```
db.users.find()
```
