#!/bin/bas
# Sparql query
query=$(cat ./sparql/languagesSupported.sparql)

# Query Wikidata with SPARQL
response=$(curl -G --data-urlencode query="${query}" https://lingualibre.org/sparql?format=json)
# Save to file
echo "QUERY= ${query}"
echo "RESPONSE= ${response}"
echo "${response}" | jq '.results.bindings' > languages.json

echo "${response}" | jq '.results.bindings' | jq 'map({"language":.language.value,"wikidata":.wikidata.value,"iso":.code.value})' > languages2.json
echo "${response}" | jq '.results.bindings | map({"language":.language.value,"wikidata":.wikidata.value,"iso":.code.value})' > languages3.json

# Use jq to extract values from the JSON response
values=$(echo "$response" | jq '.results.bindings[].YOUR_FIELD_NAME_HERE.value')

# Iterate over the values and process them in the loop
for value in $values; do
  echo "Processing value: $value"
  # Your processing code here
done
