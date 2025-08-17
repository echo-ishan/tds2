# Use stable Python 3.11 slim for compatibility
FROM python:3.11-slim

# Environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    DUCKDB_EXTENSION_DIRECTORY=/tmp/.duckdb \
    PATH="/root/.local/bin:$PATH" \
    PORT=7860

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    build-essential \
    pkg-config \
    git \
    && rm -rf /var/lib/apt/lists/*

# Prepare directories with proper permissions
RUN mkdir -p /tmp/.duckdb /app/logs /app/uploads && \
    chmod 777 /tmp && \
    chmod -R 755 /app

# Copy requirements for Docker cache optimization
COPY requirements.txt .

# Upgrade pip tools and install dependencies
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r requirements.txt

# Copy all application source code
COPY . .

# Add a non-root user and set permissions
RUN useradd -m -u 1000 appuser && \
    chown -R appuser:appuser /app /tmp/.duckdb

# Switch to non-root user for runtime security
USER appuser

# Expose port (Hugging Face Spaces uses PORT environment variable)
EXPOSE 7860

# Healthcheck to verify the app is running
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:7860/api || exit 1

# Command to run your app
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860", "--workers", "1"]
