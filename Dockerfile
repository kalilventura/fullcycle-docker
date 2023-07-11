## Stage 01 - build the app
FROM golang:1.21-rc-alpine AS builder

WORKDIR /build
COPY go.mod ./
RUN go mod download

COPY hello-world.go ./

RUN go build -ldflags="-s -w" -o app

## Stage 02 - build the container with the binary generated by the previous step
FROM scratch

COPY --from=builder /build/app /

CMD [ "./app" ]
