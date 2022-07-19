FROM amazon/aws-cli AS downloader


#ARG AWS_ROLE_ARN="arn:aws:iam::128765541338:role/mgmt-keysmaker-gh"
ARG AWS_WEB_IDENTITY_TOKEN_FILE="/var/run/secrets/eks.amazonaws.com/serviceaccount/token"

RUN aws sts get-caller-identity 
RUN aws s3 sync s3://keysmaker/gh /src

FROM alpine:3.16.0

RUN apk add --update --no-cache openssl

WORKDIR app
#COPY *.enc entrypoint.sh ./
COPY --from=downloader /src/*.enc ./
COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
