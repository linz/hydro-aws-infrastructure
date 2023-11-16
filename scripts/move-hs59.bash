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
echo 'Move folders HS59/ "Interim TDP" "Mobilisation_Calibration" "Project_Monitoring" to Authoritative_Surveys/HS59/LINZ_QA' >&2
for folder in "Interim TDP" "Mobilisation_Calibration" "Project_Monitoring"; do
    "${move_command[@]}" \
        "${bucket_root}/HS59/${folder}" \
        "${authoritative_surveys}/HS59/LINZ_QA/${folder}"
done

echo >&2
echo >&2
echo 'Move everything under HS59/FinalDeliverables to Authoritative_Surveys/HS59' >&2
"${move_command[@]}" \
    "${bucket_root}/HS59/FinalDeliverables/" \
    "${authoritative_surveys}/HS59/"

echo >&2
echo >&2
echo 'Move HS60-69/HS66/DML/FinalDeliverables to Authoritative_Surveys/HS66/DML' >&2
"${move_command[@]}" \
    "${bucket_root}/HS60-69/HS66/DML/FinalDeliverables/" \
    "${authoritative_surveys}/HS66/DML/"

echo >&2
echo >&2
echo 'Move HS60-69/HS66/DML/LINZ_QA to Authoritative_Surveys/HS66/DML/LINZ_QA' >&2
"${move_command[@]}" \
    "${bucket_root}/HS60-69/HS66/DML/LINZ_QA/" \
    "${authoritative_surveys}/HS66/DML/LINZ_QA/"

echo >&2
echo >&2
echo 'Move HS60-69/HS66/iXblue/FinalDeliverables to Authoritative_Surveys/HS66/iXblue' >&2
"${move_command[@]}" \
    "${bucket_root}/HS60-69/HS66/iXblue/FinalDeliverables/" \
    "${authoritative_surveys}/HS66/iXblue/"

echo >&2
echo >&2
echo 'Move HS60-69/HS66/iXblue/LINZ_QA to Authoritative_Surveys/HS66/iXblue/LINZ_QA' >&2
"${move_command[@]}" \
    "${bucket_root}/HS60-69/HS66/iXblue/LINZ_QA/" \
    "${authoritative_surveys}/HS66/iXblue/LINZ_QA/"

echo >&2
echo >&2
echo 'Move HS60-69/HS66-new/DML to Authoritative_Surveys/HS66/DML/1_Raw' >&2
"${move_command[@]}" \
    "${bucket_root}/HS60-69/HS66-new/DML/" \
    "${authoritative_surveys}/HS66/DML/1_Raw/"
