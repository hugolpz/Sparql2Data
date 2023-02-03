## SPARQL2DATA
Given valid SPARQL queries, an endpoint and an output format, writes the response to a local file.

### Usage
```bash
# Documentation
bash ./script.sh -h

# Basic usage
bash ./script.sh -q ./demo.sparql -s wikidata -f json
# Output response in ./data/demo.json

# Run multiple SPARQL queries in `./sparql`
# Requires prefixes in those filenames: WD-*, LL-*, CC-*.
bash loop.sh
```

### Cron
This repository integrates a github action file.
On github, a cron command runs `loop.sh` every night at 1:30am, updating the repository.
You can adapt it to your needs.
