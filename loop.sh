## Targets
targetsLL=$(ls -1 ./sparql/LL-L*)
targetsWD=$(ls -1 ./sparql/WD-*)

for file in $targetsLL; do
  bash ./script.sh -q $file --service lingualibre --format json 
done

for file in $targetsWD; do
  bash ./script.sh -q $file --service wikidata --format json 
done