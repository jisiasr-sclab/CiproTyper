FROM python:3.12-slim
RUN apt-get update && apt-get install -y --no-install-recommends ncbi-blast+ && rm -rf /var/lib/apt/lists/*
WORKDIR /srv
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app/ app/
COPY scripts/ scripts/
COPY data/Table_S1.xlsx data/Table_S1.xlsx
COPY data/bvbrc_cache.json data/bvbrc_cache.json
COPY refs/ refs/
RUN python scripts/build_db.py
ENV PORT=8000 DATA_DIR=/srv/data BVBRC_CACHE_URL=file:///srv/data/bvbrc_cache.json
EXPOSE 8000
CMD ["sh", "-c", "uvicorn app.main:app --host 0.0.0.0 --port ${PORT}"]
