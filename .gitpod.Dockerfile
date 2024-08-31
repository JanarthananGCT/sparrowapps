FROM gitpod/workspace-full:latest

# Install NVM, Node.js, and mkcert
USER gitpod

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 18 \
    && nvm use 18 \
    && npm install -g npm@latest
    && npm install -g https://ssdk.surveysparrow.dev/ssdk.tgz

# Install mkcert
RUN sudo apt-get update \
    && sudo apt-get install -y libnss3-tools \
    && wget -O mkcert https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64 \
    && chmod +x mkcert \
    && sudo mv mkcert /usr/local/bin/

# Ensure mkcert is available in the path and trust the CA
RUN mkcert -install

# This will ensure the right Node.js version is used when the container starts
ENV NVM_DIR="/home/gitpod/.nvm"
ENV NODE_VERSION="18"
RUN echo "source $NVM_DIR/nvm.sh && nvm use $NODE_VERSION" >> /home/gitpod/.bashrc
