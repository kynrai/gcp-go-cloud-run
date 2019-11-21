FROM golang:latest as build
WORKDIR /src
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o /api ./cmd/sample-api

FROM alpine
RUN apk add --no-cache ca-certificates
COPY --from=build api /
CMD ["/api"]