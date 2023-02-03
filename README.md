Given valid SPARQL queries, an endpoint and an output format, writes the response to a local file.

### Usage
```bash
# Documentation
bash ./script.sh -h

# Basic usage
bash ./script.sh -q ./demo.sparql -s wikidata -f json
# Output response in ./data/demo.json

# Run multiple SPARQL queries in `./sparql/`
# Requires prefixes in those filenames: WD-*, LL-*, WC-*.
bash loop.sh
```

### Auto-update
This repository integrates a github action file.
On github, a cron command runs `loop.sh` every night at 1:30am, then commit changes to the repository.
You can adapt to your needs.

To work on your own server, ignore this .yml commit cycle, create your own cron file fitting to your needs. 
