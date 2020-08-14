FROM nixos/nix

RUN apk update && \
    set -ex && \
    apk --no-cache add curl jq bc bzip2 git sudo bash && \
    echo 'sandbox = false' > /etc/nix/nix.conf && \
    adduser maker --home /home/maker --disabled-password --gecos "" --shell /bin/sh && \
    echo "maker ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/maker &&\
    chmod 0440 /etc/sudoers.d/maker && \
    chown -R maker /nix

CMD /bin/sh -l
USER maker
ENV USER maker
WORKDIR /home/maker

RUN touch .bash_profile \
 && sudo curl https://dapp.tools/install | sh
