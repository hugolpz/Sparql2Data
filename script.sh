#!/bin/bash

# filename: script.sh
# author: @hugolpz

showHelp() {
# `cat << EOF` This means that cat should stop reading when EOF is detected
cat << EOF  
# Usage: script.sh [-q,--sparql <arg1>] [-s,--service <arg2>] [f,--format <arg3>]#
# Optional arguments:
#   -q, --query, --sparql
#           Path to a file with a valid SPARQL query, i.e './query.sparql'
#   -s, --service
#           Query service among 'wikidata', 'lingualibre', 'commons'. Default: 'wikidata'.
#   -f, --format
#           Output format among 'xml', 'json', 'csv', 'tsv'.
#
# Example: script.sh ./sparql/LL-demo.sparql -s lingualibre -f json
EOF
# EOF is found above and hence cat command stops reading. This is equivalent to echo but much neater when printing out.
}

# Set default values for variables
sparql="./sparql/WD-demo.sparql"
service="wikidata"
format="json"
output="WD-demo.json"

# Parse command line options
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    -q|--query|--sparql)
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
    \?) echo "Invalid option. Please use `bssh ./script.sh -h`" >&2
    ;;
  esac
  shift
done

# ASSIGN OUTPUT FILENAME
output=$(basename "${sparql}" .sparql).${format}

# ASSIGN SERVICE
serviceURL=""
if [ "$service" == "lingualibre" ]; then
  serviceURL="https://lingualibre.org/sparql"
elif [ "$service" == "commons" ]; then
  serviceURL="https://commons-query.wikimedia.org/sparql"
else
  serviceURL="https://query.wikidata.org/sparql"
fi

# DEV COMMENTS TO REMOVE
echo "Parameter 'q' is: $sparql"
echo "Parameter 'f' is: $format"
echo "└─ Output name is: ${output}"
echo "Parameter 's' is: $service"
echo "└─ Service URL is: ${serviceURL}"

# Sparql query
query=$(cat ${sparql})
echo "QUERY= ${query}" | head -n 5

# CURL SPARQL query on Wikidata
response=$(curl -G --data-urlencode query="${query}" ${serviceURL}?format=${format})
echo "RESPONSE: ${response}" | head -n 20

# CLEAN BY FORMAT
if [ "$format" == "json" ]; then
    clean=$(echo "${response}" | jq '.results.bindings' | jq 'map(map_values(.value))' | sed -E "s/https?:\/\/.*\/entity\///g" )
else
    clean=${response}
fi
echo "CLEANED: ${clean}" | head -n 20

# PRINT TO ./DATA/ FOLDER
echo "PRINT TO ./data/${output}"
firstline=$(echo "${clean}" | head -n 1)
if [[ ${format} == "json" && ${firstline:0:1} == "[" ]]; then
    echo "${clean}" > "./data/${output}"; 
elif [ ${format} != "json" ]; then
    echo "${clean}" > "./data/${output}"; 
else
    echo "XHR response appears invalid, was NOT printed to ./data/${output} ."
fi

echo "* ********************************************* *"
echo " "
