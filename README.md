1. docker swarm init
2. docker network create --driver overlay --attachable ana-overlay

Содержимое docker-compose
    1. Kafka брокер в однонодовой инсталляции. Для запуска сервера Apache Kafka требуется сначала запустить сервер Zookeeper 
    2. Контейнеры mongodb-source и mongodb-target
    3. Контейнер kafka connect, которые соединяет базы данных с Kafka
    