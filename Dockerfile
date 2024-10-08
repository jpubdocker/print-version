FROM --platform=$BUILDPLATFORM golang:1.21.6 AS build

ARG TARGETARCH
WORKDIR /go/src/github.com/jpubdocker/print-version
COPY . .
RUN GOARCH=$TARGETARCH make build

FROM gcr.io/distroless/base-debian11:debug
LABEL org.opencontainers.image.source=https://github.com/jpubdocker/print-version

COPY --from=build /go/src/github.com/jpubdocker/print-version/bin/print-version /usr/local/bin/
COPY --from=build /go/src/github.com/jpubdocker/print-version/live.txt /var/tmp/

ENTRYPOINT ["print-version"]
