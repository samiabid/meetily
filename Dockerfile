FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    ffmpeg \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy backend requirements and install Python dependencies
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy backend application code to /app (not /app/app)
COPY backend/app/*.py ./

# Expose port
EXPOSE 8000

# Run the FastAPI application (Railway provides PORT env variable)
CMD uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}
