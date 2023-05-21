jq \
  --argjson languagesGenderData "$(<./data/LL-LanguagesGenderData.json)"  \
  --argjson languagesActive "$(<./data/LL-LanguagesActive.json)" \
  --argjson languagesRecordsData "$(<./data/LL-LanguagesRecordsData.json)" \
  --argjson languagesPopulationData "$(<./data/WD-LanguagesPopulationData.json)" \
  '[ $languagesGenderData + $languagesActive + $languagesRecordsData + $languagesPopulationData | group_by(.wikidata) | .[] | reduce .[] as $obj ({}; . * $obj) ]' <<< "{}" > ./data/languages-gallery.json
