# Historical files

These three files were included in the supplied archive but are not used by the current Dockerfile or `app.main:app`:

- `app.py`: earlier standalone application; expects a different database schema and reference/static layout.
- `septatype.db`: matching historical schema with 2,734 isolates.
- `fetch_references.py`: earlier reference generator, writing to a `references/` directory beside that script.

They are preserved verbatim for traceability. This is an archive, not a second supported runnable application. Use the root README to run the current application.
