FROM golang as builder
RUN mkdir /app
WORKDIR /app
COPY . .
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build .

FROM golang:alpine as runner
RUN mkdir /app
COPY --from=builder /app/smokescreen /app
COPY --from=builder /app/config.yaml /app
WORKDIR /app
RUN ls
ENTRYPOINT ["./smokescreen", "--config-file=config.yaml"]
