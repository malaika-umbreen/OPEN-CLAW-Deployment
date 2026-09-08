FROM node:22

WORKDIR /app

# Install openclaw and dependencies
RUN npm install -g openclaw@latest

# Create a non-root user
RUN useradd -m -s /bin/bash openclaw-user

# Switch to non-root user
USER openclaw-user

WORKDIR /home/openclaw-user

# Create config directory and set gateway config
RUN mkdir -p /home/openclaw-user/.openclaw && \
    echo '{"gateway":{"mode":"local"}}' > /home/openclaw-user/.openclaw/openclaw.json

CMD ["openclaw", "gateway", "--port", "18789"]
