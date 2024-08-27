FROM horologger/btcshell:v0.0.1
LABEL maintainer="horologger <horologger@protonmail.com>"

# Start9 Packaging
RUN apk add --no-cache yq cargo pkgconfig openssl openssl-dev openssl-libs-static git; \
    rm -f /var/cache/apk/*

COPY --chmod=755 docker_entrypoint.sh /usr/local/bin/