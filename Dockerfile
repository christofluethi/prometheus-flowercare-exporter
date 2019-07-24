FROM golang:alpine AS build-env
RUN apk add git
RUN git clone https://github.com/xperimental/flowercare-exporter /flowercare-exporter
RUN ls /flowercare-exporter
WORKDIR /flowercare-exporter
RUN go build -o flowercare-exporter

FROM alpine
RUN apk add bluez-deprecated
WORKDIR /app
COPY --from=build-env /flowercare-exporter/flowercare-exporter /app/
ENTRYPOINT ["/app/flowercare-exporter"]
