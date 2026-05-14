FROM python:3.8.19-slim

WORKDIR /

# Install tools yang dibutuhkan way.sh agar tidak error saat eksekusi runtime
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    sudo \
    ufw \
    build-essential \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copies the trainer code
COPY trainer /trainer

# Jalankan task python yang nantinya memanggil way.sh
ENTRYPOINT ["python", "-m", "trainer.task"]
