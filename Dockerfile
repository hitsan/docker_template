# FROM any image
FROM ubuntu:22.04

ARG USER_ID
ARG GROUP_ID
ARG USER

# Make user
#RUN deluser <user>
RUN groupadd -g ${GROUP_ID} ${USER} && \
    useradd -u ${USER_ID} -g ${GROUP_ID} -m ${USER} && \
    mkdir -p /home/${USER}/.ssh && \
    chown -R ${USER}:${USER} /home/${USER}

# Install git
RUN apt-get -y update \
 && apt-get -y --no-install-recommends install \
    git \
    ssh \
 && apt-get clean \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

# Set ssh-key
USER ${USER}
WORKDIR /home/${USER}
RUN ssh-keyscan github.com >> /home/${USER}/.ssh/known_hosts

