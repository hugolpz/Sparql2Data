jq --slurp --sort-keys 'add | group_by(.wikidata) | map(add) | map(select(.records > 0)) | sort_by((.records | tonumber) // 0) | reverse' \
    ./data/LL-LanguagesSpeakersData.json ./data/LL-LanguagesGenderData.json ./data/LL-LanguagesActive.json ./data/LL-LanguagesRecordsData.json ./data/WD-LanguagesPopulationData.json \
    > ./data/languages-gallery.json
