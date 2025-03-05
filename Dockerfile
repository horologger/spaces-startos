FROM horologger/spaces:v0.0.7
LABEL maintainer="horologger <horologger@protonmail.com>"

COPY --chmod=755 docker_entrypoint.sh /usr/local/bin/
