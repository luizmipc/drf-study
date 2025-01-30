FROM python:3.12-slim-bookworm

# Every print statement or log message is immediately written to 
# the console without being stored in a buffer first. This ensures 
# that logs appear in real time instead of being delayed.
ENV PYTHONUNBUFFERED=1

# Prevents Python from writing .pyc and __pycache__
ENV PYTHONDONTWRITEBYTECODE=1

# Defines where the venv will be for uv
ENV UV_VENV=/app/.venv

# Copies the project into the image
COPY . /app
COPY ./entrypoint.sh /entrypoint.sh

# Define where to work
WORKDIR /app

# Allows execution
RUN chmod +x /entrypoint.sh

RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    /venv/bin/pip install -r /app/requirements.txt && \
    adduser --disabled-password --no-create-home duser && \
    chown -R duser:duser /app && \
    chmod +x /entrypoint.sh

ENV PATH="/scripts:/venv/bin:$PATH"
# Sync the project into a new environment, using the frozen lockfile

# Expose 8000 port to access
EXPOSE 8000

CMD ["/entrypoint.sh"]


