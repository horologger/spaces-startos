FROM horologger/btcshell:v0.0.3
LABEL maintainer="horologger <horologger@protonmail.com>"

# Start9 Packaging
RUN apk add --no-cache yq cargo pkgconfig openssh openssl openssl-dev openssl-libs-static gcompat gcc git npm; \
    rm -f /var/cache/apk/*

# RUN git clone https://github.com/spacesprotocol/spaced && cd spaced ; \
RUN git clone https://github.com/horologger/spaced && cd spaced ; \
    cargo build --release ; \
    cargo install --path node --locked ; cd ..
# echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.bashrc

# Install Fabric
# RUN npm install -g @spacesprotocol/fabric

# libgc++ g++ clang make rustup 
# apk add clang make libgc++ g++
# https://www.rust-lang.org/tools/install
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# cargo install cargo-risczero
# cargo risczero install
# RUN git clone https://github.com/andrewlunde/subspacer && cd subspacer ; \
#     cargo build --release ; \
#     cargo install --path node --locked

COPY --chmod=755 docker_entrypoint.sh /usr/local/bin/
