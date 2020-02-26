FROM fedora:31
LABEL maintainer="abogatikov@devalexb.com"
RUN dnf update -y && \
    dnf install 'dnf-command(copr)' -y && \
    dnf copr enable jdoss/wireguard -y && \
    dnf install wireguard-dkms wireguard-tools iproute kernel-devel kernel-headers -y && \
    dnf clean all -y && \
    rm -rf /var/cache/dnf

COPY docker-entrypoint.sh /bin/docker-entrypoint.sh
RUN chmod +x /bin/docker-entrypoint.sh

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "run-server" ]