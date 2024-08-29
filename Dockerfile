FROM horologger/btcshell:v0.0.1
LABEL maintainer="horologger <horologger@protonmail.com>"

# Start9 Packaging
RUN apk add --no-cache yq cargo pkgconfig openssl openssl-dev openssl-libs-static gcompat git; \
    rm -f /var/cache/apk/*

# RUN git clone https://github.com/spacesprotocol/spaced && cd spaced ; \
RUN git clone https://github.com/andrewlunde/spaced && cd spaced ; \
    cargo build --release ; \
    cargo install --path node --locked
# echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc

COPY --chmod=755 docker_entrypoint.sh /usr/local/bin/
