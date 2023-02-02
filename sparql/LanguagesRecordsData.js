# MediaWiki:LanguagesRecordsData.js
SELECT 
?language ?languageLabel ?wikidata ?iso
(COUNT(?record) AS ?records)
(COUNT(DISTINCT(?recordLabel)) AS ?words) 
#(ROUND(1000*?words/?records)/10 AS ?percent)
WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en" . }
  ?language prop:P2 entity:Q4 .              # Filter: P2 'instance of' is Q4 'language'
  OPTIONAL { ?language prop:P12 ?wikidata }  # Assign value: language's P12 'wikidata id' into ?wikidata
  OPTIONAL { ?language prop:P13 ?iso }      # Assign value: language's P13 'ISO 639-3' into ?iso
  ?record prop:P2 entity:Q2 .  # Filter: P2 'instance of' is Q2 'record'
  ?record prop:P4 ?language .  # Filter: P4 'language' match a value of ?language
  ?record rdfs:label ?recordLabel. # Assign value: label to ?itemLabel
  # FILTER ( (COUNT(record)) > 0).
}
GROUP BY ?language ?languageLabel ?wikidata ?iso
ORDER BY DESC(?records)