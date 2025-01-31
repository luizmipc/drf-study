FROM python:3.12-slim-bookworm

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

COPY . /app
COPY ./entrypoint.sh /entrypoint.sh
COPY ./pyproject.toml .

WORKDIR /app

RUN chmod +x /entrypoint.sh

RUN pip install --upgrade pip && pip --no-cache-dir install poetry

RUN poetry install

ENV PATH="/scripts:/venv/bin:$PATH"

EXPOSE 8000

ENTRYPOINT [ "/entrypoint.sh" ]