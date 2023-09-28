#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail
shopt -s failglob inherit_errexit


bucket_root='s3://hydro-data-bucket-418528898914'

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
    aws s3 mv --dryrun --quiet --recursive \
        "${bucket_root}/${prefix}/" \
        "${bucket_root}/Authoritative_Surveys/"
done &> hsxx-xx.log
