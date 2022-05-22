FROM fedora:36 as base
WORKDIR /usr/local/bin
RUN dnf install ansible shadow-utils.x86_64 -y \
    && dnf clean all \
    && rm -rf /var/cache/yum

FROM base as matt
RUN groupadd --gid 1000 kurtwood
RUN adduser --uid 1000 --gid 1000 kurtwood
WORKDIR /home/kurtwood

FROM matt
COPY . .
CMD ["sh", "-c", "ansible-playbook local.yml"]
