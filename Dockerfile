FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y nodejs
RUN apt-get install -y npm

RUN npm install -g http-server

WORKDIR /app

COPY . . 

CMD ["http-server"] 