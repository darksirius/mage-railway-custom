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

WORKDIR /home/src

COPY requirements.txt /home/src/requirements.txt

RUN python -m pip install --no-cache-dir "pip==24.0" \
    && python -m pip install --no-cache-dir -r /home/src/requirements.txt \
    && python -m pip install --no-cache-dir --force-reinstall "Jinja2==3.1.6" \
    && python -c "import jinja2; print('Jinja2 version:', jinja2.__version__)" \
    && python -c "import mage_ai, pandas, pyarrow, jinja2, markupsafe; print('Dependencias OK')"

COPY . /home/src/

RUN chmod +x /home/src/start.sh

EXPOSE 8080

CMD ["/home/src/start.sh"]