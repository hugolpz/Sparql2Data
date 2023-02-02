#!/bin/bash

# filename: script.sh
# author: @hugolpz

showHelp() {
# `cat << EOF` This means that cat should stop reading when EOF is detected
cat << EOF  
# Usage: script.sh [-q,--sparql <arg1>] [-s,--service <arg2>] [f,--format <arg3>]#
# Optional arguments:
#   -q, --sparql
#           Relative path of a file with a valid SPARQL query, i.e './query.sparql'
#   -s, --service
#           Query service among 'wikidata', 'lingualibre', 'commons'. Default to 'wikidata'.
#   -f, --format
#           Output format among json, xml, csv, tsv
#
# Example: script.sh ./sparql/LL-demo.sparql -s lingualibre -f json
EOF
# EOF is found above and hence cat command stops reading. This is equivalent to echo but much neater when printing out.
}

# Set default values for variables
sparql="./sparql/WD-demo.sparql"
service="wikidata"
format="json"
output=$(basename "${sparql}" .sparql).${format}


# Parse command line options
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -q|--sparql)
    sparql="$2"
    shift
    ;;
    -s|--service)
    service="$2"
    shift
    ;;
    -f|--format)
    format="$2"
    shift
    ;;
    -h|--help)
    showHelp
    exit 0
    ;;
    \?) echo "Invalid option: -$OPTARG. Please use `man ./script.sh`" >&2
    ;;
  esac
  shift
done

serviceURL=""
# ASSIGN SERVICE
if [ "$service" == "lingualibre" ]; then
  serviceURL="https://lingualibre.org/sparql"
elif [ "$service" == "commons" ]; then
  serviceURL="https://commons-query.wikimedia.org/sparql"
else
  serviceURL="https://www.wikidata.org/sparql"
fi

# DEV COMMENTS TO REMOVE
echo "Parameter 'q' is: $sparql"
echo "  Output name is: ${output}"
echo "Parameter 's' is: $service"
echo "  Service URL is: ${serviceURL}"
echo "Parameter 'f' is: $format"

# Query Wikidata with SPARQL
query=$(cat ${sparql})
response=$(curl -G --data-urlencode query="${query}" ${serviceURL}?format=${format})
# Save to file
echo "QUERY= ${query}"
echo "RESPONSE= ${response}" | head -n 20
echo "${response}" | jq '.results.bindings' | jq 'map(map_values(.value))' | sed -e "s/https:\/\/.*\/entity\///g" > ./data/${output}
