FROM golang:1.19.5-alpine AS builder
RUN apk add --no-cache git
RUN go install -v github.com/projectdiscovery/katana/cmd/katana@latest

FROM alpine:3.16.2
RUN apk -U upgrade --no-cache \
    && apk add --no-cache bind-tools ca-certificates
COPY --from=builder /go/bin/katana /usr/local/bin/

ENTRYPOINT ["katana"]
