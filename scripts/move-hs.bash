#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail
shopt -s failglob inherit_errexit

# Prefix `echo` to just print the commands
# Suffix `--dryrun` to do a dry run, not actually moving any files
move_command=(echo aws s3 mv --dryrun --quiet --recursive)

bucket_root='s3://hydro-data-bucket-418528898914'
authoritative_surveys="${bucket_root}/Authoritative_Surveys/"

echo 'Move everything from HSXX-XX to Authoritative_Surveys'
#
# This replaces the first part of the prefixes with a fixed string, so we have to use `scripts/dupes.bash hsxx-xx.log`
# to check for duplicates before running for real.
#
# Found all prefixes by running
# `aws s3 ls s3://hydro-data-bucket-418528898914 | rg --only-matching --pcre2 '(?<=^                           PRE )HS\d\d-\d\d.*'`
#
# TODO: Include HS60-69 when ready
for prefix in HS10-19 HS47-51 HS52-54 HS55-57 HS70-79; do
    "${move_command[@]}" "${bucket_root}/${prefix}/" "$authoritative_surveys"
done &> hsxx-xx.log

echo
echo 'Move HS71, which is highest priority'
# Requires "Change ownership to hydro account" for HS71.
"${move_command[@]}" \
    "${bucket_root}/HS71/" \
    "${authoritative_surveys}/HS71/"

echo
pre='HS41 - Whangaroa Harbour'
post='HS41_Whangaroa_Harbour'
echo "Rename '${pre}' to 'Authoritative_Surveys/${post}'"
"${move_command[@]}" \
    "${bucket_root}/${pre}/" \
    "${authoritative_surveys}/${post}/"
