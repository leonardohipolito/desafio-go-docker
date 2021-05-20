FROM golang:alpine AS builder
RUN apk update && apk add --no-cache git
WORKDIR /go/bin
COPY app.go .
RUN go build -ldflags="-w -s" app.go

FROM scratch
WORKDIR /go/bin
COPY --from=builder /go/bin/app app
ENTRYPOINT ["./app"]