# Consolidated statistics for all languages -> `data/languages-gallery.json`
jq --slurp --sort-keys 'add | group_by(.wikidata) | map(add) | map(select(.records > 0)) | sort_by((.records | tonumber) // 0) | walk(if type == "string" then tonumber? // . else . end) | reverse' \
     data/LL-LanguagesSpeakers.json data/LL-LanguagesRecordingsGender.json ./data/LL-LanguagesActive.json data/LL-LanguagesRecordings.json data/WD-LanguagesPopulation.json \
    > ./data/languages-gallery.json


