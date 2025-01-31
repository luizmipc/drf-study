#!/bin/bash
# This is a comment
echo "running!"
uv run app/manage.py runserver 0.0.0.0:8000 # in dev
#uv run manage.py runserver 0.0.0.0:8000 # in prod