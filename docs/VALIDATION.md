# Organization checks

Checked on 18 November 2026:

- All 35 files from the supplied ZIP are accounted for in FILE_MAP.md.
- All 34 supplied files other than Dockerfile are byte-identical to the input.
- All Python files parse successfully.
- The seed builder creates a database containing 2,734 isolates from the included workbook.
- The current app starts with an isolated temporary writable database.
- The homepage, JavaScript, CSS and Plotly endpoints return HTTP 200.
- Metadata, isolate browsing, species rules, accuracy statistics and grammar endpoints return HTTP 200 with valid parameters.
- The normal BV-BRC loader reads the included cache through a local file URI.

These checks use dependencies available in the editing environment. Docker is unavailable here, so a fresh container build and the pinned dependency installation were not executed. Genome alignment with external BLAST+ and live Render deployment were not rerun; the analysis source files are unchanged.

Generated databases, bytecode and temporary verification files are excluded from the public archive. The supplied historical database is retained under legacy/.
