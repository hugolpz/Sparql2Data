## Targets
targetsWD=$(ls -1 ./sparql/WD-*)
targetsWC=$(ls -1 ./sparql/WC-*)
targetsLL=$(ls -1 ./sparql/LL-*)

for file in $targetsWD; do
  bash ./script.sh --sparql $file --service wikidata --format json 
done

for file in $targetsWC; do
  bash ./script.sh --sparql $file --service commons --format json 
done

for file in $targetsLL; do
  bash ./script.sh --sparql $file --service lingualibre --format json 
done
