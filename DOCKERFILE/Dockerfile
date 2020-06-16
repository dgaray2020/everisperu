FROM golang:1.8-alpine
ADD . /go/src/Hello-World 
RUN go install Hello-World

FROM alpine:latest
COPY --from=0 /go/bin/Hello-World .
ENV PORT 8080
CMD ["./Hello-World]
