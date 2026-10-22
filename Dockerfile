# 1. Base image: small Linux (Alpine) with Python already installed
FROM python:3.12-alpine

LABEL maintainer="Merey Yeltaeva" \
      group="IT2-2301" \
      student_id="37603"

# 2. Working directory inside the image — all next commands run here
WORKDIR /app

# 3. Default (non-secret) values; can be overridden: docker run -e STUDENT_NAME=...
ENV STUDENT_NAME="Merey" \
    STUDENT_SURNAME="Yeltaeva" \
    STUDENT_GROUP="IT2-2301" \
    STUDENT_ID="37603" \
    APP_PORT=5000 \
    PYTHONUNBUFFERED=1

# 4. Copy project files from the computer into the image
COPY app/ ./app/
COPY config/ ./config/
COPY Yeltaeva_Merey_info.txt ./

# 5. Commands executed while BUILDING the image
RUN python -m py_compile app/app.py \
    && adduser -D appuser \
    && chown -R appuser /app

# Run as a normal user, not root (security best practice)
USER appuser

# 6. Document the port the application listens on
EXPOSE 5000

# Docker checks every 30s that the app answers on /health
HEALTHCHECK --interval=30s --timeout=3s CMD wget -qO- http://127.0.0.1:5000/health || exit 1

# 7. Command executed when a CONTAINER starts
CMD ["python", "app/app.py"]
