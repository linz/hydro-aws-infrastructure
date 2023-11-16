#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail
shopt -s failglob inherit_errexit

# Prefix `echo` to just print the commands
# Suffix `--dryrun` to do a dry run, not actually moving any files
move_command=(aws s3 mv --dryrun --recursive)

bucket_root='s3://hydro-data-bucket-418528898914'
authoritative_surveys="${bucket_root}/Authoritative_Surveys"

echo >&2
echo >&2
echo 'Move HS60-69' >&2
"${move_command[@]}" "${bucket_root}/HS60-69/" "${authoritative_surveys}/"
