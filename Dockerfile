FROM golang:1.22-alpine AS builder
RUN apk add --no-cache git
WORKDIR /src
RUN git clone https://github.com/9seconds/mtg.git . && \
    CGO_ENABLED=0 go build -o /mtg .

FROM alpine:3.19
RUN apk add --no-cache ca-certificates
COPY --from=builder /mtg /usr/local/bin/mtg
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
