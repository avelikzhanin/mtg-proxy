FROM nineseconds/mtg:2 AS mtg
 
FROM alpine:3.19
RUN apk add --no-cache ca-certificates
COPY --from=mtg /mtg /usr/local/bin/mtg
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
