#!/bin/sh
Container="mtbsystem"
ProjectName="mtbsystem"
#docker run采用host网络模式，使得网络互通

case "$1" in
    build)
        cd dockerbase
        docker build -t ricoder/go-env .
        cd ..
    ;;
    run)
        docker run --name=$Container --network=host -p 3306 -p 6379 -p 8500 -p 9999 -p 5324 -p 8082 -p 8083 -p 8084 -p 8085 -p 8090 -d -v `pwd`:/data/deploy/$ProjectName ricoder/go-env
    ;;
    init)
        docker exec $Container bash /data/deploy/$ProjectName/dockerbase/init.sh $2
    ;;
    start)
        docker start $Container
    ;;
    stop)
        docker stop $Container
    ;;
    remove)
        docker stop $Container
        docker rm $Container
    ;;
    login)
        docker exec -it $Container /bin/bash
    ;;
    info)
        docker ps -a -f name=$Container
    ;;
    port)
        docker port $Container
    ;;
    *)
        echo "Usage: build|run|init[chmod,conf]|start|stop|remove|login|info|port"
        exit 3
    ;;
esac
