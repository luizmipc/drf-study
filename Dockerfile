FROM python:3.12-slim-bookworm

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV UV_VENV=/app/.venv 



# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin/:$PATH"

# Copy the project into the image
COPY . /app
COPY ./entrypoint.sh /entrypoint.sh

# Sync the project into a new environment, using the frozen lockfile
WORKDIR /app
RUN chmod +x /entrypoint.sh

# The installer requires curl (and certificates) to download the release archive
RUN pip install uv
# Create a virtual environment inside the container
RUN uv sync

EXPOSE 8000


CMD ["/entrypoint.sh"]