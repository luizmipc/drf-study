FROM python:3.12-slim-bookworm
# e.g., using a hash from a previous release
COPY --from=ghcr.io/astral-sh/uv@sha256:2381d6aa60c326b71fd40023f921a0a3b8f91b14d5db6b90402e65a635053709 /uv /uvx /bin/

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV UV_VENV=/app/.venv 



# Copy the project into the image
COPY pyproject.toml /pyproject.toml
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh


# Create a virtual environment inside the container
RUN uv sync --frozen

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin/:$PATH"

# COPY . /app | add only in prod
# WORKDIR /app | add only in prod if required

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]