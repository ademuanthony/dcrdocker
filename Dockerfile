FROM alpine:latest

RUN apk add --no-cache bash curl

RUN curl -L https://github.com/decred/decred-release/releases/download/v1.8.1/dcrinstall-linux-amd64-v1.8.1 -o dcrinstall
RUN chmod +x dcrinstall

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["data"]

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
