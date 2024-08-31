FROM gitpod/workspace-full:latest

# Install NVM
USER gitpod

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
    && export NVM_DIR="$HOME/.nvm" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 18 \
    && nvm use 18 \
    && npm install -g npm@latest

# This will ensure the right Node.js version is used when the container starts
ENV NVM_DIR="/home/gitpod/.nvm"
ENV NODE_VERSION="18"
RUN echo "source $NVM_DIR/nvm.sh && nvm use $NODE_VERSION" >> /home/gitpod/.bashrc
