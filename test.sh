#!/bin/bas
# Sparql query
llqs=https://www.wikidata.org/sparql
wdqs=https://www.wikidata.org/sparql
query=$(cat ./sparql/LanguagesPopulationData.sparql)

# Query Wikidata with SPARQL
response=$(curl -G --data-urlencode query="${query}" https://query.wikidata.org/sparql?format=json)
# Save to file
echo "QUERY= ${query}"
echo "RESPONSE= ${response}" | head 
# echo "${response}" | jq '.results.bindings' > output.json
echo "${response}" | jq '.results.bindings' | jq 'map(map_values(.value))' | sed -e "s/https:\/\/lingualibre.org\/entity\///g" > output.json

# Use jq to extract values from the JSON response
values=$(echo "$response" | jq '.results.bindings[].language.value')

# Iterate over the values and process them in the loop
for value in $values; do
  echo "Processing value: $value"
  # Your processing code here
done
