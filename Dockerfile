FROM alpine:latest

RUN apk add --no-cache bash curl

VOLUME ["data"]

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
