FROM golang:1.16.0-alpine3.13 AS builder
WORKDIR /workspace/bill-app
# ENV GO111MODULE=on CGO_ENABLED=0 GOOS=linux GOARCH=amd64
# download dependency
# COPY go.mod go.sum .
# RUN  go mod download
# RUN go install honnef.co/go/tools/cmd/staticcheck@v0.1.2
COPY . .
# RUN go vet ./... && staticcheck ./... && go test ./... && go build -o /bin/server
RUN go vet ./... && go build -o /bin/server

FROM alpine:latest AS release
# Copy from builder
COPY --from=builder /bin/server /bin/server
ENTRYPOINT ["./bin/server"]