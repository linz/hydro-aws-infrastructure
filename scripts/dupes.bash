#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail
shopt -s failglob inherit_errexit

# Run with a dryrun log file to check for duplicate target keys

bucket_root='s3://hydro-data-bucket-418528898914'

# Remove everything up to the target key
sed --expression="s!(dryrun) move: ${bucket_root}/.* to ${bucket_root}/!!" ${@+"$@"} | \
    # Sort
    sort | \
    # Print only duplicates
    uniq --repeated
