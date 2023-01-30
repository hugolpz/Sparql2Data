#!/bin/bash


# 
query=$(cat languages.sparql)

# Query Wikidata with SPARQL
response=$(curl -G --data-urlencode 'query=${query}' https://lingualibre.org/sparql?format=json) | jq '.results.bindings[]'
# Save to file
echo "$reponse" > languages.json

# Use jq to extract values from the JSON response
values=$(echo "$response" | jq '.results.bindings[].YOUR_FIELD_NAME_HERE.value')

# Iterate over the values and process them in the loop
for value in $values; do
  echo "Processing value: $value"
  # Your processing code here
done
