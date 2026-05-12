FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    MAGE_ENV=production \
    MAGE_CODE_PATH=/home/src \
    PROJECT_NAME=mage_project \
    USER_CODE_PATH=/home/src/mage_project \
    HIDE_ENV_VAR_VALUES=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    g++ \
    curl \
    git \
    ca-certificates \
    libpq-dev \
    unixodbc-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/requirements.txt

RUN pip install --upgrade pip setuptools wheel \
    && pip install -r /app/requirements.txt

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 6789

CMD ["/app/start.sh"]