FROM amazon/aws-cli AS downloader

RUN aws s3 sync s3://keysmaker/gh /src


FROM alpine:3.16.0

RUN apk add --update --no-cache openssl

WORKDIR app
#COPY *.enc entrypoint.sh ./
COPY --from=downloader /src/*.enc ./
COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
