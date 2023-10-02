#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail
shopt -s failglob inherit_errexit

# Prefix `echo` to just print the commands
# Suffix `--dryrun` to do a dry run, not actually moving any files
move_command=(aws s3 mv --dryrun --recursive)

bucket_root='s3://hydro-data-bucket-418528898914'
authoritative_surveys="${bucket_root}/Authoritative_Surveys"

#echo 'Move everything from HSXX-XX to Authoritative_Surveys' >&2
#
# This replaces the first part of the prefixes with a fixed string, so we have to use `scripts/dupes.bash hsxx-xx.log`
# to check for duplicates before running for real.
#
# Found all prefixes by running
# `aws s3 ls s3://hydro-data-bucket-418528898914 | rg --only-matching --pcre2 '(?<=^                           PRE )HS\d\d-\d\d.*'`
#
#for prefix in HS10-19 HS47-51 HS52-54 HS55-57 HS70-79; do
#    "${move_command[@]}" "${bucket_root}/${prefix}/" "${authoritative_surveys}/"
#done

#echo >&2
#echo >&2
#pre='HS41 - Whangaroa Harbour'
#post='HS41_Whangaroa_Harbour'
#echo "Rename '${pre}' to 'Authoritative_Surveys/${post}'" >&2
#"${move_command[@]}" \
#    "${bucket_root}/${pre}/" \
#    "${authoritative_surveys}/${post}/"

#echo >&2
#echo >&2
#pre='HS42 - Auckland Islands'
#post='HS42_Auckland_Islands'
#echo "Rename '${pre}' to 'Authoritative_Surveys/${post}'" >&2
#"${move_command[@]}" \
#    "${bucket_root}/${pre}/" \
#    "${authoritative_surveys}/${post}/"

#echo >&2
#echo >&2
#pre='HS43 - Houhora_Harbour'
#post='HS43_Houhora_Harbour'
#echo "Rename '${pre}' to 'Authoritative_Surveys/${post}'" >&2
#"${move_command[@]}" \
#    "${bucket_root}/${pre}/" \
#    "${authoritative_surveys}/${post}/"

#echo >&2
#echo >&2
#pre='HS44 - Mangonui Harbour'
#post='HS44_Mangonui_Harbour'
#echo "Rename '${pre}' to 'Authoritative_Surveys/${post}'" >&2
#"${move_command[@]}" \
#    "${bucket_root}/${pre}/" \
#    "${authoritative_surveys}/${post}/"

#echo >&2
#echo >&2
#pre='HS45 - Omaha-Cove'
#post='HS45_Omaha_Cove'
#echo "Rename '${pre}' to 'Authoritative_Surveys/${post}'" >&2
#"${move_command[@]}" \
#    "${bucket_root}/${pre}/" \
#    "${authoritative_surveys}/${post}/"

#echo >&2
#echo >&2
#pre='HS46 - Doubtless_Rangaunu-bay'
#post='HS46_Doubtless_Rangaunu_bay'
#echo "Rename '${pre}' to 'Authoritative_Surveys/${post}'" >&2
#"${move_command[@]}" \
#    "${bucket_root}/${pre}/" \
#    "${authoritative_surveys}/${post}/"

#echo >&2
#echo >&2
#echo 'Move everything starting with "HS" into "Authoritative_Surveys" up to HS49' >&2
#echo 'Replace spaces and hyphens with underscores' >&2
#for original_prefix in \
#    'HS20_Abel_Tasman' \
#    'HS21_Akaroa_Harbour' \
#    'HS22_Milford_Sound' \
#    'HS23_Dusky_BreakseaSounds' \
#    'HS24_Milford_Sound_Unsurveyed_Area' \
#    'HS25_Doubtful_Thompson_Sounds' \
#    'HS27_Great_Barrier_Island' \
#    'HS28_Paterson_Inlet' \
#    'HS29_Poor_Knights_Islands_2009' \
#    'HS30_Hen_Chicken_Islands' \
#    'HS31_Chatham_Islands' \
#    'HS32_Mercury_Bay' \
#    'HS33_Poor_Knights_Islands' \
#    'HS35_Whitianga_Harbour' \
#    'HS36_Shipping_Lane_6' \
#    'HS38-Bay of Islands' \
#    'HS39_Bay_of_Plenty' \
#    'HS40_Chalky_Preservation_Inlet' \
#    'HS41_Tutuakaka_Harbour' \
#    'HS47-Whangaruru-Harbour' \
#    'HS48-Hokianga Harbour' \
#    'HS49-Parengarenga Harbour'; do
#    new_prefix="$(printf '%s' "$original_prefix" | tr ' -' '_')"
#    "${move_command[@]}" \
#        "${bucket_root}/${original_prefix}/" \
#        "${authoritative_surveys}/${new_prefix}/"
#    echo >&2
#done

echo >&2
echo >&2
echo 'Move everything from Data/Authoritative_Surveys to Authoritative_Surveys' >&2
"${move_command[@]}" \
    "${bucket_root}/Data/Authoritative_Surveys/" \
    "${authoritative_surveys}/"

echo >&2
echo >&2
echo 'Move HYD-2007-2008 to Authoritative_Surveys' >&2
"${move_command[@]}" \
    "${bucket_root}/HYD-2007-2008/" \
    "${authoritative_surveys}/HYD-2007-2008/"

echo >&2
echo >&2
echo 'Move Authoritative_Surveys/HS58/CentralFiords to Authoritative_Surveys/HS58_CentralFiords' >&2
"${move_command[@]}" \
    "${authoritative_surveys}/HS58/CentralFiords/" \
    "${authoritative_surveys}/HS58_CentralFiords/"

echo >&2
echo >&2
echo 'Move Authoritative_Surveys/HS58/SouthernFiords to Authoritative_Surveys/HS58_SouthernFiords' >&2
"${move_command[@]}" \
    "${authoritative_surveys}/HS58/SouthernFiords/" \
    "${authoritative_surveys}/HS58_SouthernFiords/"

echo >&2
echo >&2
echo 'Move "HS57 - Kaikoura - Cape Campbell/HYD 1718-HS57 DML finals compress" to "Authoritative_Surveys/HS57_Kaikoura_CapeCampbell/DML"' >&2
"${move_command[@]}" \
    "${bucket_root}/HS57 - Kaikoura - Cape Campbell/HYD 1718-HS57 DML finals compress/" \
    "${authoritative_surveys}/HS57_Kaikoura_CapeCampbell/DML/"

echo >&2
echo >&2
echo 'Move "HS57 - Kaikoura - Cape Campbell/HYD 1718-HS57 iXblue finals compress finals compress" to "Authoritative_Surveys/HS57_Kaikoura_CapeCampbell/IXBLUE"' >&2
"${move_command[@]}" \
    "${bucket_root}/HS57 - Kaikoura - Cape Campbell/HYD 1718-HS57 iXblue finals compress finals compress/" \
    "${authoritative_surveys}/HS57_Kaikoura_CapeCampbell/IXBLUE/"

echo >&2
echo >&2
echo 'Take all remaining files/folders under "HS57 - Kaikoura - Cape Campbell" and put them into "Authoritative_Surveys/HS57/LINZ_QA"' >&2
"${move_command[@]}" \
    "${bucket_root}/HS57 - Kaikoura - Cape Campbell/" \
    "${authoritative_surveys}/HS57/LINZ_QA/"

echo >&2
echo >&2
echo 'Move "HS57-WCD" to "Authoritative_Surveys/HS57_Kaikoura_CapeCampbell/IXBLUE/WCD"' >&2
"${move_command[@]}" \
    "${bucket_root}/HS57-WCD/" \
    "${authoritative_surveys}/HS57_Kaikoura_CapeCampbell/IXBLUE/WCD/"
