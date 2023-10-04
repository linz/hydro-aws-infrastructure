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
echo 'Take all remaining files/folders under "HS57 - Kaikoura - Cape Campbell" and put them into "Authoritative_Surveys/HS57/LINZ_QA"' >&2
"${move_command[@]}" \
    "${bucket_root}/HS57 - Kaikoura - Cape Campbell/" \
    "${authoritative_surveys}/HS57/LINZ_QA/"
