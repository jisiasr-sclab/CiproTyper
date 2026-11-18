# Setup and use

## Local installation

Use Python 3.12 and NCBI BLAST+ (`blastn` and `makeblastdb` on PATH). On Debian/Ubuntu, install BLAST+ with `sudo apt-get install ncbi-blast+`.

From the repository root:

```bash
python3.12 -m venv .venv
. .venv/bin/activate
python -m pip install -r requirements.txt
python scripts/build_db.py
export BVBRC_CACHE_URL="$(python -c 'from pathlib import Path; print(Path("data/bvbrc_cache.json").resolve().as_uri())')"
uvicorn app.main:app --host 127.0.0.1 --port 8000
```

The environment command above is for POSIX shells. On other systems, set `BVBRC_CACHE_URL` to the absolute file URI of `data/bvbrc_cache.json`. The original default points to the old remote repository; the override makes this public copy independent of that URL.

`build_db.py` creates `data/seed.db`. On first startup the application creates the working `data/septatype.db`. Do not substitute the historical database in `legacy/`.

## Persistent Docker data

```bash
docker volume create ciprotyper-data
docker run --rm -p 8000:8000 --mount source=ciprotyper-data,target=/var/lib/ciprotyper -e DATA_DIR=/var/lib/ciprotyper ciprotyper
```

The seed and cache remain in `/srv/data`; the writable database lives in the mounted volume. Configure `ADMIN_TOKEN` privately if curator functions are needed. Do not place credentials in source files.

## Configuration

| Variable | Purpose |
|---|---|
| `PORT` | Docker server port; defaults to 8000 |
| `DATA_DIR` | Directory for the writable database |
| `SEED_DB` | Optional seed-database override |
| `REFS_DIR` | Optional reference-directory override |
| `ADMIN_TOKEN` | Curator credential supplied privately |
| `BVBRC_CACHE_URL` | URI for the saved BV-BRC cache |
| `BVBRC_AUTOLOAD` | Set to `0` to disable automatic BV-BRC loading |

Other existing limits and thresholds are documented in `app/config.py`; this reorganization does not change them.

## Utilities

- `python scripts/build_db.py`: rebuild the founding seed from the workbook. This is not a replacement for backing up a live database.
- `python scripts/fetch_bvbrc.py --help`: show the BV-BRC update utility's options. It requires network access when fetching data.
- `legacy/fetch_references.py`: historical reference generator, not the current multi-species reference installation procedure. Do not use it to replace `refs/`.

## Uploading to the public repository

Extract the ZIP and upload the **contents of `CiproTyper/`** to the public repository root. Keep the folder structure intact. The private flat deployment repository does not need these changes. This archive does not publish or update either repository automatically.
