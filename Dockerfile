FROM node:20

RUN apt update && \
    apt install -y socat curl net-tools && \
    npm install -g --force @agentmemory/agentmemory@latest

CMD bash -c '\
AGENTMEMORY_USE_DOCKER=1 agentmemory --port 3111 & \
sleep 20 && \
socat TCP-LISTEN:3111,fork,reuseaddr TCP:127.0.0.1:3111 & \
socat TCP-LISTEN:3112,fork,reuseaddr TCP:127.0.0.1:3112 & \
socat TCP-LISTEN:3113,fork,reuseaddr TCP:127.0.0.1:3113 && \
wait'
