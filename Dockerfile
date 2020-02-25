FROM fedora:31
LABEL maintainer="abogatikov@devalexb.com"
RUN dnf install 'dnf-command(copr)' -y && \
    dnf copr enable jdoss/wireguard -y && \
    dnf install wireguard-dkms wireguard-tools -y && \
    dnf clean all -y && \
    rm -rf /var/cache/dnf