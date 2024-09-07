FROM nginx
WORKDIR /home/
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./server.c .
COPY ./entrypoint.sh .
RUN apt update
RUN apt install -y gcc spawn-fcgi libfcgi-dev
ENTRYPOINT [ "sh", "./entrypoint.sh" ]