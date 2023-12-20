Given valid SPARQL queries, an endpoint and an output format, writes the response to a persistent local file. 

### Description
Sparql2data is a tiny github-hosted tool which uses your #SPARQL query, fetch #Wikidata or other wikibase, save result daily (or weekly) into a persitent file, so your webpage doesnt wait 20secs for its data to show up.
You can then build a basic HTML/CSS/JS webpage to display your data. A working proof of concept is https://github.com/hugolpz/LanguagesGallery/ .

### Usage
```bash
# Documentation
bash ./script.sh -h

# Basic usage
bash ./script.sh -q ./WD-demo.sparql -s wikidata -f xml
# Output response in ./data/WD-demo.xml

# Run multiple SPARQL queries in `./sparql/`
# Requires prefixes in those filenames: WD-*, LL-*, WC-*.
bash loop.sh
```

### Github actions: auto-updates
This repository integrates a github action file.
On github, a cron command runs `loop.sh` every night at 1:30am, then commit changes to the repository.
You can adapt to your needs.

To work on your own server, ignore this .yml commit cycle, create your own cron file fitting to your needs. 

### Github pages: xhr queries
The repository is configured as a github page. Generated data files are therefore public.
<br>Example : [./data/LL-demo.json](https://hugolpz.github.io/Sparql2Data/data/LL-demo.json)
