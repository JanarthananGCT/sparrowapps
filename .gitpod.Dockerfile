FROM gitpod/workspace-full:latest

USER gitpod

# Install NVM and Node.js
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
ENV NVM_DIR="/home/gitpod/.nvm"
RUN [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && nvm install 18 && nvm use 18

# Install npm and CLI tool
RUN npm install -g npm@latest
RUN npm install https://ssdk.surveysparrow.dev/ssdk.tgz -g

# Install Ngrok
RUN wget https://bin.equinox.io/c/4b7f9d9d7b4e/ngrok-stable-linux-amd64.zip
RUN unzip ngrok-stable-linux-amd64.zip
RUN sudo mv ngrok /usr/local/bin/

# Install mkcert
RUN sudo apt-get update && sudo apt-get install -y libnss3-tools
RUN wget -O mkcert https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64
RUN chmod +x mkcert && sudo mv mkcert /usr/local/bin/
RUN mkcert -install

ENV NVM_DIR="/home/gitpod/.nvm"
ENV NODE_VERSION="18"
RUN echo "source $NVM_DIR/nvm.sh && nvm use $NODE_VERSION" >> /home/gitpod/.bashrc
