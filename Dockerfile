FROM elixir:1.20-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN mix local.hex --force && \
    mix local.rebar --force

RUN groupadd -g 1001 ai-dome && \
    useradd -m -d /home/ai-dome -s /bin/bash -u 1001 -g 1001 ai-dome && \
    mkdir -p /home/ai-dome/project && \
    chown -R ai-dome:ai-dome /home/ai-dome

USER ai-dome

WORKDIR /home/ai-dome/project

EXPOSE 8080

CMD ["mix", "run", "--no-halt"]
