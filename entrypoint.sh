#!/bin/bash
# This is a comment
echo "running!"
cd app
uv run manage.py makemigrations
uv run manage.py migrate
uv run manage.py runserver 0.0.0.0:8000 # in dev
#uv run manage.py runserver 0.0.0.0:8000 # in prod