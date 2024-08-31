FROM gitpod/workspace-full:latest

USER gitpod

# Install NVM, Node.js, mkcert, and Ngrok
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 18 \
    && nvm use 18 \
    && npm install -g npm@latest \
    && npm install https://ssdk.surveysparrow.dev/ssdk.tgz -g \
    && wget https://bin.equinox.io/c/4b7f9d9d7b4e/ngrok-stable-linux-amd64.zip \
    && unzip ngrok-stable-linux-amd64.zip \
    && sudo mv ngrok /usr/local/bin/

# Install mkcert
RUN sudo apt-get update \
    && sudo apt-get install -y libnss3-tools \
    && wget -O mkcert https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64 \
    && chmod +x mkcert \
    && sudo mv mkcert /usr/local/bin/

# Ensure mkcert is available in the path and trust the CA
RUN mkcert -install

ENV NVM_DIR="/home/gitpod/.nvm"
ENV NODE_VERSION="18"
RUN echo "source $NVM_DIR/nvm.sh && nvm use $NODE_VERSION" >> /home/gitpod/.bashrc
