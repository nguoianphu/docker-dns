# ISC BIND DNS servers
ISC BIND DNS servers - Docker images.

[![Build Status](https://travis-ci.org/nguoianphu/docker-dns.svg?branch=master)](https://travis-ci.org/nguoianphu/docker-dns) [![Image size](https://images.microbadger.com/badges/image/nguoianphu/docker-dns.svg)](https://microbadger.com/images/nguoianphu/docker-dns "Get your own image badge on microbadger.com")


## BIND DNS 9.11.x
- Branch **master**
- BIND version **9.11.0-P1**

#### Build and run
    
    docker build -t "dns" .
    docker run -d -p 53:53 --name my-dns dns
    
#### or just run
    
    docker run -d -p 53:53 --name my-dns nguoianphu/docker-dns


## BIND DNS 9.10.x
- Branch **9.10**
- BIND version **9.10.4-P4**

#### Build and run
    
    docker build -t "dns" .
    docker run -d -p 53:53 --name my-dns dns
    
#### or just run
    
    docker run -d -p 53:53 --name my-dns nguoianphu/docker-dns:9.10

## BIND DNS 9.9.x
- Branch **9.9**
- BIND version **9.9.9-P4**

#### Build and run
    
    docker build -t "dns" .
    docker run -d -p 53:53 --name my-dns dns
    
#### or just run
    
    docker run -d -p 53:53 --name my-dns nguoianphu/docker-dns:9.9
